import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salon_admin/features/auth/data/datasource/auth_datasource.dart';
import 'package:salon_admin/features/auth/data/repository/auth_repoimplementation.dart';
import 'package:salon_admin/features/auth/domain/usecase/auth_usecase.dart';
import 'package:salon_admin/features/dashboard/data/datasource/booking_datasource.dart';
import 'package:salon_admin/features/dashboard/data/repository/booking_repositoryimpl.dart';
import 'package:salon_admin/features/dashboard/domain/usecase/booking_usecase.dart';
import 'package:salon_admin/features/services/data/datasource/service_datasource.dart';
import 'package:salon_admin/features/services/data/repository/service_repoimplementation.dart';
import 'package:salon_admin/features/services/domain/usecase/service_usecase.dart';
import 'package:salon_admin/features/staff/data/datasource/staff_datasource.dart';
import 'package:salon_admin/features/staff/data/repository/staff_repoimplementation.dart';
import 'package:salon_admin/features/staff/domain/usecase/staff_usecase.dart';

class Injection {
  /// AUTH
  static final authLocalDataSource = AuthLocalDataSource();
  static final authRepository = AuthRepositoryImpl(authLocalDataSource);

  static final loginUseCase = LoginUseCase(authRepository);
  static final logoutUseCase = LogoutUseCase(authRepository);
  static final checkLoginUseCase = CheckLoginUseCase(authRepository);

  /// SERVICE
  static final firestore = FirebaseFirestore.instance;
  static final serviceDataSource = ServiceRemoteDataSourceImpl(firestore);
  static final serviceRepository =
      ServiceRepositoryImpl(serviceDataSource);

  static final serviceUseCase = ServiceUsecase(serviceRepository);

  // / STAFF
  static final staffDataSource = StaffRemoteDataSource(firestore);
  static final staffRepository =
      StaffRepositoryImpl(staffDataSource);

  static final staffUseCase = StaffUseCase(staffRepository);

  /// BOOKING
static final bookingDataSource =
    BookingRemoteDataSource(firestore);

static final bookingRepository =
    BookingRepositoryImpl(bookingDataSource);

static final bookingUseCase =
    BookingUsecase(bookingRepository);
}