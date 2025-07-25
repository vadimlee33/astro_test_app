import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String uid;
  final String phone;
  final DateTime createdAt;
  final int balance;

  const User({
    required this.uid,
    required this.phone,
    required this.createdAt,
    required this.balance,
  });

  @override
  List<Object> get props => [uid, phone, balance, createdAt];

  User copyWith({
    String? uid,
    String? phone,
    DateTime? createdAt,
    int? balance,
  }) {
    return User(
      uid: uid ?? this.uid,
      phone: phone ?? this.phone,
      createdAt: createdAt ?? this.createdAt,
      balance: balance ?? this.balance,
    );
  }
}
