
import 'package:salon_admin/features/staff/domain/entity/staff_entity.dart';

import '../../domain/repository/staff_repository.dart';
import '../datasource/staff_datasource.dart';
import '../model/staff_model.dart';

class StaffRepositoryImpl implements StaffRepository {
  final StaffRemoteDataSource dataSource;

  StaffRepositoryImpl(this.dataSource);

  @override
  Future<void> addStaff(StaffEntity staff) async {
    final model = StaffModel(
      id: staff.id,
      name: staff.name,
      image: staff.image,
      description: staff.description,
      serviceIds: staff.serviceIds,
    );
    await dataSource.addStaff(model);
  }

  @override
  Future<List<StaffEntity>> getStaff() async {
    final data = await dataSource.getStaff();

    return data
        .map((e) => StaffEntity(
              id: e.id,
              name: e.name,
              image: e.image,
              description: e.description,
              serviceIds: e.serviceIds,
            ))
        .toList();
  }

  @override
  Future<void> deleteStaff(String id) async {
    await dataSource.deleteStaff(id);
  }

  @override
  Future<List<StaffEntity>> getStaffByService(String serviceId) async {
    final data = await dataSource.getStaffByService(serviceId);

    return data
        .map((e) => StaffEntity(
              id: e.id,
              name: e.name,
              image: e.image,
              description: e.description,
              serviceIds: e.serviceIds,
            ))
        .toList();
  }

  @override
Future<String> uploadStaffImage(String path) {
  return dataSource.uploadStaffImage(path);
}
}