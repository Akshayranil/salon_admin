import 'dart:convert';
import 'package:http/http.dart' as http;
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

   
Future<String> uploadStaffImage(String filePath) async {
  final cloudName = "dbmzu0vdn";
  final uploadPreset = "staff_image";

  final url = Uri.parse(
    "https://api.cloudinary.com/v1_1/$cloudName/image/upload",
  );

  final request = http.MultipartRequest("POST", url);

  request.fields['upload_preset'] = uploadPreset;

  request.files.add(
    await http.MultipartFile.fromPath('file', filePath),
  );

  final response = await request.send();

  if (response.statusCode == 200) {
    final responseData = await response.stream.bytesToString();
    final jsonData = json.decode(responseData);

    return jsonData['secure_url']; // 🔥 THIS IS YOUR IMAGE URL
  } else {
    throw Exception("Image upload failed");
  }
}
}