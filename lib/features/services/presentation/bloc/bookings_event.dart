part of 'bookings_bloc.dart';

abstract class BookingsEvent extends Equatable {
  const BookingsEvent();

  @override
  List<Object> get props => [];
}

class CreateBookingEvent extends BookingsEvent {
  final Booking booking;
  const CreateBookingEvent(this.booking);

  @override
  List<Object> get props => [booking];
}

class GetMyBookingsEvent extends BookingsEvent {}
