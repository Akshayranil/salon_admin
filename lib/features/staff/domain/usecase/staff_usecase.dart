
import 'package:salon_admin/features/staff/domain/entity/staff_entity.dart';

import '../repository/staff_repository.dart';

class StaffUseCase {
  final StaffRepository repository;

  StaffUseCase(this.repository);

  Future<void> addStaff(StaffEntity staff) {
    return repository.addStaff(staff);
  }

  Future<List<StaffEntity>> getStaff() {
    return repository.getStaff();
  }

  Future<void> deleteStaff(String id) {
    return repository.deleteStaff(id);
  }

  Future<List<StaffEntity>> getStaffByService(String serviceId) {
    return repository.getStaffByService(serviceId);
  }

  Future<String> uploadStaffImage(String path) {
  return repository.uploadStaffImage(path);
}
}