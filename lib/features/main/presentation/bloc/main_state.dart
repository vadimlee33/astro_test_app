import 'package:equatable/equatable.dart';
import '../../../auth/domain/entities/user.dart';

abstract class MainState extends Equatable {
  const MainState();

  @override
  List<Object?> get props => [];
}

class MainInitial extends MainState {}

class MainLoading extends MainState {}

class MainLoaded extends MainState {
  final User user;

  const MainLoaded(this.user);

  @override
  List<Object?> get props => [user];
}

class MainError extends MainState {
  final String message;

  const MainError(this.message);

  @override
  List<Object?> get props => [message];
}
