import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:salon_admin/features/staff/domain/entity/staff_entity.dart';
import 'package:salon_admin/features/staff/domain/usecase/staff_usecase.dart';

part 'staff_event.dart';
part 'staff_state.dart';

class StaffBloc extends Bloc<StaffEvent, StaffState> {
  final StaffUseCase useCase;

  StaffBloc(this.useCase) : super(StaffInitial()) {
    on<AddStaffEvent>(_addStaff);
    on<LoadStaffEvent>(_loadStaff);
    on<DeleteStaffEvent>(_deleteStaff);
    on<LoadStaffByServiceEvent>(_filterStaff);
  }

  Future<void> _addStaff(
      AddStaffEvent event, Emitter<StaffState> emit) async {
    await useCase.addStaff(
      StaffEntity(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: event.name,
        serviceIds: event.serviceIds,
      ),
    );

    add(LoadStaffEvent());
  }

  Future<void> _loadStaff(
      LoadStaffEvent event, Emitter<StaffState> emit) async {
    emit(StaffLoading());
    final data = await useCase.getStaff();
    emit(StaffLoaded(data));
  }

  Future<void> _deleteStaff(
      DeleteStaffEvent event, Emitter<StaffState> emit) async {
    await useCase.deleteStaff(event.id);
    add(LoadStaffEvent());
  }

  Future<void> _filterStaff(
      LoadStaffByServiceEvent event, Emitter<StaffState> emit) async {
    emit(StaffLoading());
    final data = await useCase.getStaffByService(event.serviceId);
    emit(StaffLoaded(data));
  }
}
