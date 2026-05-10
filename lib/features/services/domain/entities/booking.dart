import 'package:equatable/equatable.dart';

class Booking extends Equatable {
  final String id;
  final String vehicleId;
  final String serviceId;
  final DateTime? scheduledAt;
  final String status;
  final double totalPrice;
  final double latitude;
  final double longitude;
  final List<String> extraServices;

  const Booking({
    required this.id,
    required this.vehicleId,
    required this.serviceId,
    this.scheduledAt,
    required this.status,
    required this.totalPrice,
    required this.latitude,
    required this.longitude,
    this.extraServices = const [],
  });

  @override
  List<Object?> get props => [
        id,
        vehicleId,
        serviceId,
        scheduledAt,
        status,
        totalPrice,
        latitude,
        longitude,
        extraServices,
      ];
}
