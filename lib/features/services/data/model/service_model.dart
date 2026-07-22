
import 'package:salon_admin/features/services/domain/entity/service_entity.dart';

class ServiceModel extends ServiceEntity {
  ServiceModel({
    required super.id,
    required super.name,
    required super.price,
    required super.duration,
    required super.isActive,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json, String id) {
    return ServiceModel(
      id: id,
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      duration: json['duration'],
      isActive: json['isActive'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "price": price,
      "duration": duration,
      "isActive": isActive,
    };
  }
}