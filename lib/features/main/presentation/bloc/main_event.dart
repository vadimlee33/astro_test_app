import 'package:equatable/equatable.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object?> get props => [];
}

class LoadMainData extends MainEvent {
  const LoadMainData();
}

class UserServiceChanged extends MainEvent {
  const UserServiceChanged();
}
