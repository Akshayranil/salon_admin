
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salon_admin/features/services/data/model/service_model.dart';

abstract class ServiceRemoteDataSource {
  Future<void> addService(ServiceModel model);
  Future<void> updateService(ServiceModel model);
  Future<void> deleteService(String id);
  Stream<List<ServiceModel>> getServices();
}

class ServiceRemoteDataSourceImpl implements ServiceRemoteDataSource {
  final FirebaseFirestore firestore;

  ServiceRemoteDataSourceImpl(this.firestore);

  @override
  Future<void> addService(ServiceModel model) async {
    await firestore.collection('services').add(model.toJson());
  }

  @override
  Future<void> updateService(ServiceModel model) async {
    await firestore
        .collection('services')
        .doc(model.id)
        .update(model.toJson());
  }

  @override
  Future<void> deleteService(String id) async {
    await firestore.collection('services').doc(id).delete();
  }

  @override
  Stream<List<ServiceModel>> getServices() {
    return firestore.collection('services').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => ServiceModel.fromJson(doc.data(), doc.id))
          .toList();
    });
  }
}