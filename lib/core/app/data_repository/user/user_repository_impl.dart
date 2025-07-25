import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../../../features/auth/domain/entities/user.dart';
import '../../../../features/auth/domain/repositories/auth_repository.dart';
import 'user_repository.dart';

class UserRepositoryImpl extends ChangeNotifier implements UserRepository {
  User? _currentUser;
  final StreamController<User?> _userController =
      StreamController<User?>.broadcast();
  final AuthRepository _authRepository;

  UserRepositoryImpl(this._authRepository);

  @override
  User? get currentUser => _currentUser;

  @override
  Stream<User?> get userStream => _userController.stream;

  @override
  bool get isAuthenticated => _currentUser != null;

  @override
  Future<void> setUser(User user) async {
    _currentUser = user;
    _userController.add(user);
    notifyListeners();
  }

  @override
  Future<void> clearUser() async {
    _currentUser = null;
    _userController.add(null);
    notifyListeners();
  }

  @override
  Future<void> updateUser(User user) async {
    _currentUser = user;
    _userController.add(user);
    notifyListeners();
    await _authRepository.updateUser(user);
  }

  @override
  Future<void> incrementBalance(int amount) async {
    if (_currentUser != null) {
      _currentUser = _currentUser!.copyWith(
        balance: _currentUser!.balance + amount,
      );
      _userController.add(_currentUser);
      notifyListeners();
      await _authRepository.updateUser(_currentUser!);
    }
  }

  @override
  void dispose() {
    _userController.close();
    super.dispose();
  }
} 