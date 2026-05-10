import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:syria_car_care2/features/services/data/models/booking_model.dart';
import 'package:syria_car_care2/features/services/domain/entities/booking.dart';

void main() {
  const tBookingModel = BookingModel(
    id: '1',
    vehicleId: 'v1',
    serviceId: 's1',
    status: 'pending',
    totalPrice: 100.0,
    latitude: 33.5,
    longitude: 36.2,
    extraServices: ['oil_change'],
  );

  test('should be a subclass of Booking entity', () {
    expect(tBookingModel, isA<Booking>());
  });

  group('fromJson', () {
    test('should return a valid model from JSON', () {
      // arrange
      final Map<String, dynamic> jsonMap = {
        'id': '1',
        'vehicle_id': 'v1',
        'service_id': 's1',
        'status': 'pending',
        'total_price': 100.0,
        'latitude': 33.5,
        'longitude': 36.2,
        'extra_services': ['oil_change'],
      };
      // act
      final result = BookingModel.fromJson(jsonMap);
      // assert
      expect(result, tBookingModel);
    });
   group('toJson', () {
    test('should return a JSON map containing the proper data', () {
      // act
      final result = tBookingModel.toJson();
      // assert
      final expectedMap = {
        'vehicle_id': 'v1',
        'service_id': 's1',
        'scheduled_at': null,
        'status': 'pending',
        'total_price': 100.0,
        'latitude': 33.5,
        'longitude': 36.2,
        'extra_services': ['oil_change'],
      };
      expect(result, expectedMap);
    });
  });
  });
}
