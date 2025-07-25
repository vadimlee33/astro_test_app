import 'package:flutter_bloc/flutter_bloc.dart';
import 'splash_event.dart';
import 'splash_state.dart';
import '../../domain/usecases/initialize_app.dart';
import '../../../../core/usecase/usecase.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final InitializeApp initializeApp;

  SplashBloc({required this.initializeApp}) : super(SplashInitial()) {
    on<InitializeAppEvent>(_onInitializeApp);
  }

  Future<void> _onInitializeApp(
    InitializeAppEvent event,
    Emitter<SplashState> emit,
  ) async {
    emit(SplashLoading());

    final result = await initializeApp(const NoParams());

    result.fold(
      (failure) => emit(SplashError(failure.toString())),
      (_) => emit(SplashLoaded()),
    );
  }
}
