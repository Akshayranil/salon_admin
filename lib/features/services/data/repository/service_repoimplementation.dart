
import 'package:salon_admin/features/services/data/datasource/service_datasource.dart';
import 'package:salon_admin/features/services/data/model/service_model.dart';
import 'package:salon_admin/features/services/domain/entity/service_entity.dart';
import 'package:salon_admin/features/services/domain/repository/service_repository.dart';

class ServiceRepositoryImpl implements ServiceRepository {
  final ServiceRemoteDataSource remoteDataSource;

  ServiceRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> add(ServiceEntity service) async {
    final model = ServiceModel(
      id: '',
      name: service.name,
      price: service.price,
      duration: service.duration,
      isActive: service.isActive,
    );

    await remoteDataSource.addService(model);
  }

  @override
  Future<void> update(ServiceEntity service) async {
    final model = ServiceModel(
      id: service.id,
      name: service.name,
      price: service.price,
      duration: service.duration,
      isActive: service.isActive,
    );

    await remoteDataSource.updateService(model);
  }

  @override
  Future<void> delete(String id) async {
    await remoteDataSource.deleteService(id);
  }

  @override
  Stream<List<ServiceEntity>> getAll() {
    return remoteDataSource.getServices().map(
          (models) => models,
        );
  }
}