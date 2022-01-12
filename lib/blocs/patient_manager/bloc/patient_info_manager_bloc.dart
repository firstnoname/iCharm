import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:i_charm/models/models.dart';
import 'package:i_charm/models/patient/patient_info.dart';
import 'package:i_charm/services/history_api.dart';
import 'package:i_charm/services/services.dart';

part 'patient_info_manager_event.dart';
part 'patient_info_manager_state.dart';

class PatientInfoManagerBloc
    extends Bloc<PatientInfoManagerEvent, PatientInfoManagerState> {
  PatientInfoManagerBloc() : super(PatientInfoManagerInitial()) {
    on<PatientInfoManagerEventInit>(_onEventInit);
    on<PatientManagerUploadedImages>(_onUploadImages);
    on<PatientManagerEventGetHistory>(_onGetHistories);
    on<PatientManagerEventGetUploadImages>(_onGetUploadImages);
    on<PatientManagerEventAddHistory>(_onAddHistory);
  }

  PatientInfo? _patientInfo;
  get patientInfo => _patientInfo;

  Future<FutureOr<void>> _onEventInit(PatientInfoManagerEventInit event,
      Emitter<PatientInfoManagerState> emit) async {
    _patientInfo = await PatientAPI().getPatientInfo(uid: event.uid);
    if (_patientInfo != null) {
      _patientInfo!.aligner = Aligner(alignerHistory: []);
      _patientInfo!.aligner!.alignerHistory = await HistoryAPI().getHistories(
          docId: _patientInfo!.id!,
          alignerNumber: _patientInfo!.alignerInfo!.currentAligner!,
          queryDate: Timestamp.fromDate(
                  DateTime.now().subtract(const Duration(hours: 0, minutes: 0)))
              .toDate());
      emit(PatientManagerStateGetInfoSuccess(patientInfo: _patientInfo!));
    } else {
      emit(PatientManagerStateFailure());
    }
  }

  Future<FutureOr<void>> _onUploadImages(PatientManagerUploadedImages event,
      Emitter<PatientInfoManagerState> emit) async {
    await ImageAPI().addImages(
        pateintInfoId: _patientInfo!.id!,
        uploadImage: event.imagesPath,
        alignerNumber: _patientInfo!.alignerInfo!.currentAligner!);
    emit(PatientManagerStateUploadImageSuccess(patientInfo: _patientInfo!));
    emit(PatientManagerStateGetInfoSuccess(patientInfo: _patientInfo!));
  }

  FutureOr<void> _onGetUploadImages(PatientManagerEventGetUploadImages event,
      Emitter<PatientInfoManagerState> emit) async {
    emit(PatientManagerStateInProgress());
    List<UploadImage> uploadImages = await ImageAPI().getUploadImages(
        docId: _patientInfo!.id!,
        alignerNumber: _patientInfo!.alignerInfo!.currentAligner!);
    _patientInfo!.aligner!.uploadImage = uploadImages;
    emit(PatientManagerStateGetInfoSuccess(patientInfo: _patientInfo!));
  }

  Future<FutureOr<void>> _onAddHistory(PatientManagerEventAddHistory event,
      Emitter<PatientInfoManagerState> emit) async {
    AlignerHistory uploadedHistory = await HistoryAPI().addHistory(
        docId: _patientInfo!.id!,
        currentAligner: _patientInfo!.alignerInfo!.currentAligner!,
        history: event.history);
    if (uploadedHistory.id != null) {
      _patientInfo!.aligner!.alignerHistory!.add(uploadedHistory);
    }
    emit(PatientManagerStateGetInfoSuccess(patientInfo: _patientInfo!));
  }

  Future<FutureOr<void>> _onGetHistories(PatientManagerEventGetHistory event,
      Emitter<PatientInfoManagerState> emit) async {
    emit(PatientManagerStateInProgress());

    _patientInfo!.aligner!.alignerHistory = await HistoryAPI().getHistories(
      docId: _patientInfo!.id!,
      alignerNumber: _patientInfo!.alignerInfo!.currentAligner!,
      queryDate: event.queryDate.toDate(),
    );
    emit(PatientManagerStateGetInfoSuccess(patientInfo: _patientInfo!));
  }
}
