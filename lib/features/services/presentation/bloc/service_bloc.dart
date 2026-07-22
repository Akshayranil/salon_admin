import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:salon_admin/features/services/domain/entity/service_entity.dart';
import 'package:salon_admin/features/services/domain/usecase/service_usecase.dart';

part 'service_event.dart';
part 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  final ServiceUsecase usecase;

  ServiceBloc(this.usecase) : super(ServiceInitial()) {
    on<LoadServices>(_onLoad);
    on<AddServiceEvent>(_onAdd);
    on<UpdateServiceEvent>(_onUpdate);
    on<DeleteServiceEvent>(_onDelete);
  }

  Future<void> _onLoad(LoadServices event, Emitter emit) async {
    emit(ServiceLoading());

    await emit.forEach(
      usecase.getServices(),
      onData: (services) => ServiceLoaded(services),
    );
  }

  Future<void> _onAdd(AddServiceEvent event, Emitter emit) async {
    await usecase.addService(event.service);
  }

  Future<void> _onUpdate(UpdateServiceEvent event, Emitter emit) async {
    await usecase.updateService(event.service);
  }

  Future<void> _onDelete(DeleteServiceEvent event, Emitter emit) async {
    await usecase.deleteService(event.id);
  }
}
