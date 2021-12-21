import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:i_charm/models/models.dart';
import 'package:i_charm/services/services.dart';

part 'my_icharm_event.dart';
part 'my_icharm_state.dart';

class MyIcharmBloc extends Bloc<MyIcharmEvent, MyIcharmState> {
  MyIcharmBloc() : super(MyIcharmInitial()) {
    on<MyIcharmEventInit>(_onInitialize);
  }

  FutureOr<void> _onInitialize(
      MyIcharmEvent event, Emitter<MyIcharmState> emit) async {
    // call api to get patient info.
    // var patientInfo = await PatientAPI().getPatientInfo(uid: event.);
    // if (patientInfo != null) {
    //   emit(MyIcharmStateGetPatientInfoSuccess(patientInfo: patientInfo));
    // } else {
    //   emit(MyIcharmStateFailure());
    // }
  }
}
