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

class CancelBookingEvent extends BookingsEvent {
  final String bookingId;
  const CancelBookingEvent(this.bookingId);

  @override
  List<Object> get props => [bookingId];
}

class UpdateBookingStatusEvent extends BookingsEvent {
  final String bookingId;
  final String status;
  const UpdateBookingStatusEvent(this.bookingId, this.status);

  @override
  List<Object> get props => [bookingId, status];
}
