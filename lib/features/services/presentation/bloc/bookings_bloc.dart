import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/booking.dart';
import '../../domain/usecases/create_booking.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_my_bookings.dart';

part 'bookings_event.dart';
part 'bookings_state.dart';

class BookingsBloc extends Bloc<BookingsEvent, BookingsState> {
  final CreateBooking createBooking;
  final GetMyBookings getMyBookings;

  BookingsBloc({
    required this.createBooking,
    required this.getMyBookings,
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
  }
}
