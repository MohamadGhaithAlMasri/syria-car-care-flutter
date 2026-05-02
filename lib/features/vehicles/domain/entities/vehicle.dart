import 'package:equatable/equatable.dart';

class Vehicle extends Equatable {
  final String id;
  final String brand;
  final String model;
  final String year;
  final String color;
  final String plateNumber;

  const Vehicle({
    required this.id,
    required this.brand,
    required this.model,
    required this.year,
    required this.color,
    required this.plateNumber,
  });

  @override
  List<Object?> get props => [id, brand, model, year, color, plateNumber];
}
