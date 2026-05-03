import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/booking.dart';
import '../../domain/usecases/create_booking.dart';

part 'bookings_event.dart';
part 'bookings_state.dart';

class BookingsBloc extends Bloc<BookingsEvent, BookingsState> {
  final CreateBooking createBooking;

  BookingsBloc({required this.createBooking}) : super(BookingsInitial()) {
    on<CreateBookingEvent>((event, emit) async {
      emit(BookingsLoading());
      final result = await createBooking(event.booking);
      result.fold(
        (failure) => emit(BookingsError(failure.message)),
        (booking) => emit(BookingCreated(booking)),
      );
    });
  }
}
