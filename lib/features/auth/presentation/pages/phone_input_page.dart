import 'package:astro_test_app/core/constants/app_constants.dart';
import 'package:astro_test_app/core/routing/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/input_converter.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widgets/phone_input_form.dart';

class PhoneInputPage extends StatefulWidget {
  const PhoneInputPage({super.key});

  @override
  State<PhoneInputPage> createState() => _PhoneInputPageState();
}

class _PhoneInputPageState extends State<PhoneInputPage> {
  final _inputConverter = InputConverter();
  final _phoneController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите номер телефона';
    }

    final result = _inputConverter.validatePhone(value);
    return result.fold(
      (failure) => failure.message,
      (_) => null,
    );
  }

  void _onPhoneChanged(String value) {
    final formattedValue = _inputConverter.formatPhoneForDisplay(value);
    if (_phoneController.text != formattedValue) {
      _phoneController.value = TextEditingValue(
        text: formattedValue,
        selection: TextSelection.collapsed(offset: formattedValue.length),
      );
    }
  }

  void _onSubmit() {
    final phone = _phoneController.text;
    final formattedPhone = _inputConverter.formatPhoneNumber(phone);
    context.read<AuthBloc>().add(SendSmsCodeEvent(formattedPhone));
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

        if (state is SmsCodeSent) {
          final phone = _phoneController.text;
          final formattedPhone = _inputConverter.formatPhoneNumber(phone);
          CodeVerificationRoute.push(context, formattedPhone);
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Авторизация'),
          automaticallyImplyLeading: false,
        ),
        body: PhoneInputForm(
          title: 'Введите номер телефона',
          labelText: 'Номер телефона',
          hintText: '7 905 413 25 18',
          validator: _validatePhone,
          onPhoneChanged: _onPhoneChanged,
          onSubmit: _onSubmit,
          isLoading: _isLoading,
          maxLength: AppConstants.phoneLength,
        ),
      ),
    );
  }
}
