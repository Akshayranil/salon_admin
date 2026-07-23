class StaffEntity {
  final String id;
  final String name;
  final String image;
  final String description;
  final List<String> serviceIds;

  StaffEntity({required this.id, required this.name, required this.serviceIds,required this.image,required this.description});
}
