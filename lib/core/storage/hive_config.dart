import 'package:hive_flutter/hive_flutter.dart';
import '../constants/app_constants.dart';
import '../../features/auth/data/models/user_model.dart';

class HiveConfig {
  static Future<void> initialize() async {
    await Hive.initFlutter();

    Hive.registerAdapter(UserModelAdapter());

    await Hive.openBox<UserModel>(AppConstants.userBoxName);
  }

  static Future<void> close() async {
    await Hive.close();
  }

  static Box<UserModel> getUserBox() {
    return Hive.box<UserModel>(AppConstants.userBoxName);
  }
}
