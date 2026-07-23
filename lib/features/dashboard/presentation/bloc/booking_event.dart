part of 'booking_bloc.dart';

@immutable
abstract class BookingEvent {}

class CreateBookingEvent extends BookingEvent {
  final BookingEntity booking;
  CreateBookingEvent(this.booking);
}

class GetUserBookingsEvent extends BookingEvent {
  final String userId;
  GetUserBookingsEvent(this.userId);
}

class GetAllBookingsEvent extends BookingEvent {}
