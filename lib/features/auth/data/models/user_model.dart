import 'package:hive/hive.dart';
import '../../domain/entities/user.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  final String uid;

  @HiveField(1)
  final String phone;

  @HiveField(2)
  final DateTime createdAt;

  @HiveField(3)
  final int? balance;

  UserModel({
    required this.uid,
    required this.phone,
    required this.createdAt,
    this.balance = 0,
  });

  User toEntity() => User(
        uid: uid,
        phone: phone,
        createdAt: createdAt,
        balance: balance ?? 0,
      );

  factory UserModel.fromEntity(User user) => UserModel(
        uid: user.uid,
        phone: user.phone,
        createdAt: user.createdAt,
        balance: user.balance,
      );
}
