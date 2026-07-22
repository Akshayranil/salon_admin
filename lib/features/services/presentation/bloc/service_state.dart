part of 'service_bloc.dart';

abstract class ServiceState {}

class ServiceInitial extends ServiceState {}

class ServiceLoading extends ServiceState {}

class ServiceLoaded extends ServiceState {
  final List<ServiceEntity> services;

  ServiceLoaded(this.services);
}
