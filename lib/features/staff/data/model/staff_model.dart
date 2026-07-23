class StaffModel {
  final String id;
  final String name;
  final String image;
  final String description;
  final List<String> serviceIds;

  StaffModel({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.serviceIds,
  });

  factory StaffModel.fromJson(Map<String, dynamic> json, String id) {
    return StaffModel(
      id: id,
      name: json['name'],
      image: json['image'],
      description: json['description'],
      serviceIds: List<String>.from(json['serviceIds']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'serviceIds': serviceIds,
      'image': image,
      'description': description
    };
  }
}