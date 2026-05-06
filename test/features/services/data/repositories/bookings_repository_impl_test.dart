import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:syria_car_care2/core/error/failures.dart';
import 'package:syria_car_care2/features/services/data/datasources/bookings_remote_data_source.dart';
import 'package:syria_car_care2/features/services/data/models/booking_model.dart';
import 'package:syria_car_care2/features/services/data/repositories/bookings_repository_impl.dart';

class MockBookingsRemoteDataSource extends Mock implements BookingsRemoteDataSource {}

void main() {
  late BookingsRepositoryImpl repository;
  late MockBookingsRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockBookingsRemoteDataSource();
    repository = BookingsRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  const tBookingModel = BookingModel(
    id: '1',
    vehicleId: 'v1',
    serviceId: 's1',
    status: 'pending',
    totalPrice: 100.0,
    latitude: 33.5,
    longitude: 36.2,
  );

  group('updateBookingStatus', () {
    test('should return Right(null) when status is updated successfully', () async {
      // arrange
      when(() => mockRemoteDataSource.updateBookingStatus(any(), any()))
          .thenAnswer((_) async => {});

      // act
      final result = await repository.updateBookingStatus('1', 'washing');

      // assert
      expect(result, const Right(null));
      verify(() => mockRemoteDataSource.updateBookingStatus('1', 'washing')).called(1);
    });

    test('should return Left(ServerFailure) when update fails', () async {
      // arrange
      when(() => mockRemoteDataSource.updateBookingStatus(any(), any()))
          .thenThrow(Exception('Server Error'));

      // act
      final result = await repository.updateBookingStatus('1', 'washing');

      // assert
      expect(result, const Left(ServerFailure(message: 'Exception: Server Error')));
    });
  });

  group('getBookingStatus', () {
    test('should return Right(Booking) when fetch is successful', () async {
      // arrange
      when(() => mockRemoteDataSource.getBookingStatus(any()))
          .thenAnswer((_) async => tBookingModel);

      // act
      final result = await repository.getBookingStatus('1');

      // assert
      expect(result, const Right(tBookingModel));
      verify(() => mockRemoteDataSource.getBookingStatus('1')).called(1);
    });
  });
}
