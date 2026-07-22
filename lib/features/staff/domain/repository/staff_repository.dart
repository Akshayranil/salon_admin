import 'package:salon_admin/features/staff/domain/entity/staff_entity.dart';

abstract class StaffRepository {
  Future<void> addStaff(StaffEntity staff);

  Future<List<StaffEntity>> getStaff();

  Future<void> deleteStaff(String id);

  Future<List<StaffEntity>> getStaffByService(String serviceId);
}