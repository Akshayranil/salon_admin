part of 'staff_bloc.dart';

abstract class StaffState {}

class StaffInitial extends StaffState {}

class StaffLoading extends StaffState {}

class StaffLoaded extends StaffState {
  final List<StaffEntity> staffList;

  StaffLoaded(this.staffList);
}


