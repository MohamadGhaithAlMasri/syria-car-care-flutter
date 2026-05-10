import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:syria_car_care2/features/services/domain/entities/booking.dart';
import 'package:syria_car_care2/features/services/domain/usecases/cancel_booking.dart';
import 'package:syria_car_care2/features/services/domain/usecases/create_booking.dart';
import 'package:syria_car_care2/features/services/domain/usecases/get_my_bookings.dart';
import 'package:syria_car_care2/features/services/domain/usecases/update_booking_status.dart';
import 'package:syria_car_care2/features/services/presentation/bloc/bookings_bloc.dart';
import 'package:syria_car_care2/core/usecases/usecase.dart';

class MockCreateBooking extends Mock implements CreateBooking {}
class MockGetMyBookings extends Mock implements GetMyBookings {}
class MockCancelBooking extends Mock implements CancelBooking {}
class MockUpdateBookingStatus extends Mock implements UpdateBookingStatus {}

void main() {
  late BookingsBloc bloc;
  late MockCreateBooking mockCreateBooking;
  late MockGetMyBookings mockGetMyBookings;
  late MockCancelBooking mockCancelBooking;
  late MockUpdateBookingStatus mockUpdateBookingStatus;

  setUp(() {
    mockCreateBooking = MockCreateBooking();
    mockGetMyBookings = MockGetMyBookings();
    mockCancelBooking = MockCancelBooking();
    mockUpdateBookingStatus = MockUpdateBookingStatus();
    
    bloc = BookingsBloc(
      createBooking: mockCreateBooking,
      getMyBookings: mockGetMyBookings,
      cancelBooking: mockCancelBooking,
      updateBookingStatus: mockUpdateBookingStatus,
    );
  });

  registerFallbackValue(NoParams());
  registerFallbackValue(const UpdateBookingStatusParams(bookingId: '1', status: 'washing'));

  const tBooking = Booking(
    id: '1',
    vehicleId: 'v1',
    serviceId: 's1',
    status: 'pending',
    totalPrice: 100.0,
    latitude: 33.5,
    longitude: 36.2,
  );

  group('GetMyBookingsEvent', () {
    final tBookingsList = [tBooking];

    blocTest<BookingsBloc, BookingsState>(
      'should emit [BookingsLoading, BookingsLoaded] when data is gotten successfully',
      build: () {
        when(() => mockGetMyBookings(any())).thenAnswer((_) async => Right(tBookingsList));
        return bloc;
      },
      act: (bloc) => bloc.add(GetMyBookingsEvent()),
      expect: () => [
        BookingsLoading(),
        BookingsLoaded(tBookingsList),
      ],
    );
  });

  group('UpdateBookingStatusEvent', () {
    blocTest<BookingsBloc, BookingsState>(
      'should call updateBookingStatus usecase and refresh list',
      build: () {
        when(() => mockUpdateBookingStatus(any())).thenAnswer((_) async => const Right(null));
        when(() => mockGetMyBookings(any())).thenAnswer((_) async => const Right([]));
        return bloc;
      },
      act: (bloc) => bloc.add(const UpdateBookingStatusEvent('1', 'washing')),
      verify: (_) {
        verify(() => mockUpdateBookingStatus(any())).called(1);
      },
    );
  });
}
