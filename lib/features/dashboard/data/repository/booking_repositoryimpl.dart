import '../../domain/entity/booking_entity.dart';
import '../../domain/repository/booking_repository.dart';
import '../datasource/booking_datasource.dart';
import '../model/booking_model.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource remote;

  BookingRepositoryImpl(this.remote);

  @override
  Future<void> createBooking(BookingEntity booking) {
    final model = BookingModel.fromEntity(booking);
    return remote.createBooking(model);
  }

  @override
  Future<List<BookingEntity>> getUserBookings(String userId) async {
    return await remote.getUserBookings(userId);
  }

  @override
  Future<List<BookingEntity>> getAllBookings() async {
    return await remote.getAllBookings();
  }
}