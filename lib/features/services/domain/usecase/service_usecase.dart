
import 'package:salon_admin/features/services/domain/entity/service_entity.dart';
import 'package:salon_admin/features/services/domain/repository/service_repository.dart';

class ServiceUsecase {
  final ServiceRepository repository;

  ServiceUsecase(this.repository);

  Future<void> addService(ServiceEntity service) {
    return repository.add(service);
  }

  Future<void> updateService(ServiceEntity service) {
    return repository.update(service);
  }

  Future<void> deleteService(String id) {
    return repository.delete(id);
  }

  Stream<List<ServiceEntity>> getServices() {
    return repository.getAll();
  }
}