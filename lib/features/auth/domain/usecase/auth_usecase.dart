

import 'package:salon_admin/features/auth/domain/repository/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repo;
  LoginUseCase(this.repo);

  Future<void> call(String email, String password) {
    return repo.login(email, password);
  }
}

class LogoutUseCase {
  final AuthRepository repo;
  LogoutUseCase(this.repo);

  Future<void> call() {
    return repo.logout();
  }
}

class CheckLoginUseCase {
  final AuthRepository repo;
  CheckLoginUseCase(this.repo);

  Future<bool> call() {
    return repo.isLoggedIn();
  }
}