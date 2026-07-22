



import 'package:salon_admin/features/services/domain/entity/service_entity.dart';

abstract class ServiceRepository {
  Future<void> add(ServiceEntity service);
  Future<void> update(ServiceEntity service);
  Future<void> delete(String id);
  Stream<List<ServiceEntity>> getAll();
}