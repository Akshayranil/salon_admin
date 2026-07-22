

import 'package:salon_admin/features/auth/data/datasource/auth_datasource.dart';
import 'package:salon_admin/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource local;

  AuthRepositoryImpl(this.local);

  
  @override
Future<void> login(String email, String password) async {
  final cleanEmail = email.trim().toLowerCase();
  final cleanPassword = password.trim();

  print("Email: '$cleanEmail'");
  print("Password: '$cleanPassword'");

  if (cleanEmail == "akshay@gmail.com" && cleanPassword == "akshay") {
    await local.saveLogin();
  } else {
    throw Exception("Invalid credentials");
  }
}

  @override
  Future<void> logout() {
    return local.logout();
  }

  @override
  Future<bool> isLoggedIn() {
    return local.isLoggedIn();
  }
}