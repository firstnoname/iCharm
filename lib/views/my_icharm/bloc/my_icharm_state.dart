part of 'my_icharm_bloc.dart';

abstract class MyIcharmState extends Equatable {
  const MyIcharmState();

  @override
  List<Object> get props => [];
}

class MyIcharmStateFailure extends MyIcharmState {}

class MyIcharmInitial extends MyIcharmState {}

class MyIcharmStateGetPatientInfoSuccess extends MyIcharmState {
  final PatientInfo patientInfo;

  const MyIcharmStateGetPatientInfoSuccess({required this.patientInfo});
}
