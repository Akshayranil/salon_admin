part of 'service_bloc.dart';

abstract class ServiceEvent {}

class LoadServices extends ServiceEvent {}

class AddServiceEvent extends ServiceEvent {
  final ServiceEntity service;
  AddServiceEvent(this.service);
}

class UpdateServiceEvent extends ServiceEvent {
  final ServiceEntity service;
  UpdateServiceEvent(this.service);
}

class DeleteServiceEvent extends ServiceEvent {
  final String id;
  DeleteServiceEvent(this.id);
}
