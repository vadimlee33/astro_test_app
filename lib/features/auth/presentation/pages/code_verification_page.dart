import 'package:astro_test_app/core/constants/app_constants.dart';
import 'package:astro_test_app/core/routing/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/input_converter.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widgets/code_verification_form.dart';

class CodeVerificationPage extends StatefulWidget {
  final String phone;

  const CodeVerificationPage({super.key, required this.phone});

  @override
  State<CodeVerificationPage> createState() => _CodeVerificationPageState();
}

class _CodeVerificationPageState extends State<CodeVerificationPage> {
  final _inputConverter = InputConverter();
  bool _isLoading = false;

  String? _validateCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите код подтверждения';
    }

    final result = _inputConverter.validateSmsCode(value);
    return result.fold(
      (failure) => failure.message,
      (_) => null,
    );
  }

  void _onSubmit(String code) {
    context.read<AuthBloc>().add(VerifyCodeEvent(
          phone: widget.phone,
          code: code,
        ));
  }

  void _onResendCode() {
    context.read<AuthBloc>().add(SendSmsCodeEvent(widget.phone));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          setState(() => _isLoading = true);
        } else {
          setState(() => _isLoading = false);
        }

        if (state is AuthSuccess) {
          MainRoute.go(context);
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Подтверждение'),
        ),
        body: CodeVerificationForm(
          phone: widget.phone,
          title: 'Введите код подтверждения',
          subtitle: 'Код отправлен на номер',
          labelText: 'Код подтверждения',
          hintText: '123456',
          validator: _validateCode,
          onSubmit: _onSubmit,
          onResendCode: _onResendCode,
          isLoading: _isLoading,
          maxLength: AppConstants.smsCodeLength,
        ),
      ),
    );
  }
}
