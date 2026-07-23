import '../entity/booking_entity.dart';
import '../repository/booking_repository.dart';

class BookingUsecase {
  final BookingRepository repository;

  BookingUsecase(this.repository);

  Future<void> create(BookingEntity booking) {
    return repository.createBooking(booking);
  }

  Future<List<BookingEntity>> getUserBookings(String userId) {
    return repository.getUserBookings(userId);
  }

  Future<List<BookingEntity>> getAllBookings() {
    return repository.getAllBookings();
  }
}