import 'package:syria_car_care2/features/services/domain/entities/booking.dart';

class BookingModel extends Booking {
  const BookingModel({
    required super.id,
    required super.vehicleId,
    required super.serviceId,
    super.scheduledAt,
    required super.status,
    required super.totalPrice,
    required super.latitude,
    required super.longitude,
    super.extraServices,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'],
      vehicleId: json['vehicle_id'],
      serviceId: json['service_id'],
      scheduledAt: json['scheduled_at'] != null
          ? DateTime.parse(json['scheduled_at'])
          : null,
      status: json['status'],
      totalPrice: (json['total_price'] as num).toDouble(),
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      extraServices: json['extra_services'] != null
          ? List<String>.from(json['extra_services'])
          : const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vehicle_id': vehicleId,
      'service_id': serviceId,
      'scheduled_at': scheduledAt?.toIso8601String(),
      'status': status,
      'total_price': totalPrice,
      'latitude': latitude,
      'longitude': longitude,
      'extra_services': extraServices,
    };
  }
}
