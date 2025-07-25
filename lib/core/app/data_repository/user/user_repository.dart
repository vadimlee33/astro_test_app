import 'package:flutter/foundation.dart';
import '../../../../features/auth/domain/entities/user.dart';

abstract class UserRepository extends ChangeNotifier {
  User? get currentUser;
  Stream<User?> get userStream;
  bool get isAuthenticated;
  
  Future<void> setUser(User user);
  Future<void> clearUser();
  Future<void> updateUser(User user);
  Future<void> incrementBalance(int amount);
} 