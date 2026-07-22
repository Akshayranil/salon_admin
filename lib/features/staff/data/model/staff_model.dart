class StaffModel {
  final String id;
  final String name;
  final List<String> serviceIds;

  StaffModel({
    required this.id,
    required this.name,
    required this.serviceIds,
  });

  factory StaffModel.fromJson(Map<String, dynamic> json, String id) {
    return StaffModel(
      id: id,
      name: json['name'],
      serviceIds: List<String>.from(json['serviceIds']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'serviceIds': serviceIds,
    };
  }
}