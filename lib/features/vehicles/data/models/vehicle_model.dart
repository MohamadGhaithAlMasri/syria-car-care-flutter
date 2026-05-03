import '../../domain/entities/vehicle.dart';

class VehicleModel extends Vehicle {
  const VehicleModel({
    required super.id,
    required super.brand,
    required super.model,
    required super.year,
    required super.color,
    required super.plateNumber,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['id'],
      brand: json['brand'],
      model: json['model'],
      year: json['year']?.toString() ?? '',
      color: json['color'] ?? '',
      plateNumber: json['plate_number'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'brand': brand,
      'model': model,
      'year': year,
      'color': color,
      'plate_number': plateNumber,
    };
    if (id.isNotEmpty) {
      map['id'] = id;
    }
    return map;
  }
}
