part of 'patient_info_manager_bloc.dart';

abstract class PatientInfoManagerState extends Equatable {
  const PatientInfoManagerState();

  @override
  List<Object> get props => [];
}

class PatientInfoManagerInitial extends PatientInfoManagerState {}

class PatientManagerStateFailure extends PatientInfoManagerState {}

class PatientManagerStateInProgress extends PatientInfoManagerState {}

class PatientManagerStateGetInfoSuccess extends PatientInfoManagerState {
  final PatientInfo patientInfo;

  const PatientManagerStateGetInfoSuccess({required this.patientInfo});
}

class PatientManagerStateUploadImageSuccess extends PatientInfoManagerState {
  final PatientInfo patientInfo;

  const PatientManagerStateUploadImageSuccess({required this.patientInfo});

  @override
  List<Object> get props => [patientInfo];
}
