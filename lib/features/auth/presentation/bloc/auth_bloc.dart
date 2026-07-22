import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:salon_admin/features/auth/domain/usecase/auth_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase login;
  final LogoutUseCase logout;
  final CheckLoginUseCase check;

  AuthBloc(this.login, this.logout, this.check) : super(AuthInitial()) {

    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await login(event.email, event.password);
        emit(AuthLoggedIn());
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<LogoutEvent>((event, emit) async {
      await logout();
      emit(AuthLoggedOut());
    });

    on<CheckAuthEvent>((event, emit) async {
      final isLogged = await check();
      if (isLogged) {
        emit(AuthLoggedIn());
      } else {
        emit(AuthLoggedOut());
      }
    });
  }
}
