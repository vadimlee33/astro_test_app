import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SendSmsCodeEvent extends AuthEvent {
  final String phone;

  const SendSmsCodeEvent(this.phone);

  @override
  List<Object> get props => [phone];
}

class VerifyCodeEvent extends AuthEvent {
  final String phone;
  final String code;

  const VerifyCodeEvent({required this.phone, required this.code});

  @override
  List<Object> get props => [phone, code];
}

class CheckAuthStatusEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {} 