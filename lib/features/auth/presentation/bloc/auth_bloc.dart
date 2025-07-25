import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/send_sms_code.dart';
import '../../domain/usecases/verify_code.dart';
import '../../domain/usecases/get_current_user.dart';
import '../../domain/usecases/logout.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/app/data_repository/user/user_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SendSmsCode sendSmsCode;
  final VerifyCode verifyCode;
  final GetCurrentUser getCurrentUser;
  final Logout logout;
  final UserRepository userService;

  AuthBloc({
    required this.sendSmsCode,
    required this.verifyCode,
    required this.getCurrentUser,
    required this.logout,
    required this.userService,
  }) : super(AuthInitial()) {
    on<SendSmsCodeEvent>(_onSendSmsCode);
    on<VerifyCodeEvent>(_onVerifyCode);
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
    on<LogoutEvent>(_onLogout);
  }

  Future<void> _onSendSmsCode(
    SendSmsCodeEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await sendSmsCode(event.phone);

    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (_) => emit(SmsCodeSent()),
    );
  }

  Future<void> _onVerifyCode(
    VerifyCodeEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await verifyCode(VerifyCodeParams(
      phone: event.phone,
      code: event.code,
    ));

    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) {
        userService.setUser(user);
        emit(AuthSuccess(user));
      },
    );
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await getCurrentUser(NoParams());

    result.fold(
      (failure) => emit(AuthUnauthenticated()),
      (user) {
        if (user != null) {
          userService.setUser(user);
          emit(AuthSuccess(user));
        } else {
          emit(AuthUnauthenticated());
        }
      },
    );
  }

  Future<void> _onLogout(
    LogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await logout(NoParams());

    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (_) {
        userService.clearUser();
        emit(AuthUnauthenticated());
      },
    );
  }
}
