import 'package:hive/hive.dart';
import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> saveUser(UserModel user);
  Future<UserModel?> getUser();
  Future<void> deleteUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final Box<UserModel> userBox;
  
  AuthLocalDataSourceImpl(this.userBox);
  
  @override
  Future<void> saveUser(UserModel user) async {
    await userBox.put('current_user', user);
  }
  
  @override
  Future<UserModel?> getUser() async {
    return userBox.get('current_user');
  }
  
  @override
  Future<void> deleteUser() async {
    await userBox.delete('current_user');
  }
} 