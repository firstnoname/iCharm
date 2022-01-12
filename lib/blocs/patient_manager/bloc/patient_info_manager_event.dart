part of 'patient_info_manager_bloc.dart';

abstract class PatientInfoManagerEvent extends Equatable {
  const PatientInfoManagerEvent();

  @override
  List<Object> get props => [];
}

class PatientInfoManagerEventInit extends PatientInfoManagerEvent {
  final String uid;

  const PatientInfoManagerEventInit({required this.uid});
}

class PatientManagerUploadedImages extends PatientInfoManagerEvent {
  final List<String> imagesPath;

  const PatientManagerUploadedImages({
    required this.imagesPath,
  });
}

class PatientManagerEventGetHistory extends PatientInfoManagerEvent {
  final Timestamp queryDate;

  const PatientManagerEventGetHistory({required this.queryDate});
}

class PatientManagerEventGetUploadImages extends PatientInfoManagerEvent {}

class PatientManagerEventAddHistory extends PatientInfoManagerEvent {
  final AlignerHistory history;

  const PatientManagerEventAddHistory(this.history);
}
