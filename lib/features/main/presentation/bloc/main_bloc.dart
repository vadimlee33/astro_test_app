import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app/data_repository/user/user_repository.dart';
import 'main_event.dart';
import 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final UserRepository userService;

  MainBloc({
    required this.userService,
  }) : super(MainInitial()) {
    on<LoadMainData>(_onLoadMainData);
    on<UserServiceChanged>(_onUserServiceChanged);

    userService.addListener(_onUserServiceListener);
  }

  void _onLoadMainData(LoadMainData event, Emitter<MainState> emit) {
    final currentUser = userService.currentUser;
    if (currentUser != null) {
      emit(MainLoaded(currentUser));
    } else {
      emit(const MainError('Пользователь не найден'));
    }
  }

  void _onUserServiceChanged(
      UserServiceChanged event, Emitter<MainState> emit) {
    final currentUser = userService.currentUser;
    if (currentUser != null && state is! MainLoading) {
      emit(MainLoaded(currentUser));
    }
  }

  void _onUserServiceListener() {
    add(const UserServiceChanged());
  }

  @override
  Future<void> close() {
    userService.removeListener(_onUserServiceListener);
    return super.close();
  }
}
