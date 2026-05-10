part of 'bookings_bloc.dart';

abstract class BookingsState extends Equatable {
  const BookingsState();

  @override
  List<Object?> get props => [];
}

class BookingsInitial extends BookingsState {}

class BookingsLoading extends BookingsState {}

class BookingCreated extends BookingsState {
  final Booking booking;
  const BookingCreated(this.booking);

  @override
  List<Object> get props => [booking];
}

class BookingsError extends BookingsState {
  final String message;
  const BookingsError(this.message);

  @override
  List<Object> get props => [message];
}

class BookingsLoaded extends BookingsState {
  final List<Booking> bookings;
  const BookingsLoaded(this.bookings);

  @override
  List<Object> get props => [bookings];
}
