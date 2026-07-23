import '../entity/booking_entity.dart';

abstract class BookingRepository {
  Future<void> createBooking(BookingEntity booking);

  Future<List<BookingEntity>> getUserBookings(String userId);

  Future<List<BookingEntity>> getAllBookings();
}