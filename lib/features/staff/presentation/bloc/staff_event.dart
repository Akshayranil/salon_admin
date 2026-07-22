part of 'staff_bloc.dart';

abstract class StaffEvent {}

class AddStaffEvent extends StaffEvent {
  final String name;
  final List<String> serviceIds;

  AddStaffEvent(this.name, this.serviceIds);
}

class LoadStaffEvent extends StaffEvent {}

class DeleteStaffEvent extends StaffEvent {
  final String id;

  DeleteStaffEvent(this.id);
}

class LoadStaffByServiceEvent extends StaffEvent {
  final String serviceId;

  LoadStaffByServiceEvent(this.serviceId);
}


