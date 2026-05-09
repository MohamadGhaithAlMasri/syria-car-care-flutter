import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/booking.dart';
import '../../domain/usecases/create_booking.dart';
import '../../domain/usecases/cancel_booking.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/update_booking_status.dart';
import '../../domain/usecases/get_my_bookings.dart';

part 'bookings_event.dart';
part 'bookings_state.dart';

class BookingsBloc extends Bloc<BookingsEvent, BookingsState> {
  final CreateBooking createBooking;
  final GetMyBookings getMyBookings;
  final CancelBooking cancelBooking;
  final UpdateBookingStatus updateBookingStatus;

  BookingsBloc({
    required this.createBooking,
    required this.getMyBookings,
    required this.cancelBooking,
    required this.updateBookingStatus,
  }) : super(BookingsInitial()) {
    on<CreateBookingEvent>((event, emit) async {
      emit(BookingsLoading());
      final result = await createBooking(event.booking);
      result.fold(
        (failure) => emit(BookingsError(failure.message)),
        (booking) => emit(BookingCreated(booking)),
      );
    });

    on<GetMyBookingsEvent>((event, emit) async {
      emit(BookingsLoading());
      final result = await getMyBookings(NoParams());
      result.fold(
        (failure) => emit(BookingsError(failure.message)),
        (bookings) => emit(BookingsLoaded(bookings)),
      );
    });

    on<CancelBookingEvent>((event, emit) async {
      emit(BookingsLoading());
      final result = await cancelBooking(event.bookingId);
      result.fold(
        (failure) => emit(BookingsError(failure.message)),
        (_) => add(GetMyBookingsEvent()),
      );
    });

    on<UpdateBookingStatusEvent>((event, emit) async {
      final result = await updateBookingStatus(
        UpdateBookingStatusParams(
          bookingId: event.bookingId,
          status: event.status,
        ),
      );
      result.fold(
        (failure) => emit(BookingsError(failure.message)),
        (_) => add(GetMyBookingsEvent()),
      );
    });
  }
}
