import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/staff_model.dart';

class StaffRemoteDataSource {
  final FirebaseFirestore firestore;

  StaffRemoteDataSource(this.firestore);

  Future<void> addStaff(StaffModel staff) async {
    await firestore.collection('staff').doc(staff.id).set(staff.toJson());
  }

  Future<List<StaffModel>> getStaff() async {
    final snapshot = await firestore.collection('staff').get();

    return snapshot.docs
        .map((doc) => StaffModel.fromJson(doc.data(), doc.id))
        .toList();
  }

  Future<void> deleteStaff(String id) async {
    await firestore.collection('staff').doc(id).delete();
  }

  Future<List<StaffModel>> getStaffByService(String serviceId) async {
    final snapshot = await firestore
        .collection('staff')
        .where('serviceIds', arrayContains: serviceId)
        .get();

    return snapshot.docs
        .map((doc) => StaffModel.fromJson(doc.data(), doc.id))
        .toList();
  }
}