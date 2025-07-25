import 'package:flutter/material.dart';
import '../../../../core/ui_kit/app_box.dart';

class CodeVerificationForm extends StatefulWidget {
  final String phone;
  final String title;
  final String subtitle;
  final String labelText;
  final String hintText;
  final String? Function(String?)? validator;
  final void Function(String code)? onSubmit;
  final VoidCallback? onResendCode;
  final bool isLoading;
  final int maxLength;

  const CodeVerificationForm({
    super.key,
    required this.phone,
    required this.title,
    required this.subtitle,
    required this.labelText,
    required this.hintText,
    required this.validator,
    required this.onSubmit,
    required this.onResendCode,
    required this.isLoading,
    required this.maxLength,
  });

  @override
  _CodeVerificationFormState createState() => _CodeVerificationFormState();
}

class _CodeVerificationFormState extends State<CodeVerificationForm> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit?.call(_codeController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.title,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const HBox(16),
            Text(
              '${widget.subtitle}\n${widget.phone}',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const HBox(32),
            TextFormField(
              controller: _codeController,
              keyboardType: TextInputType.number,
              maxLength: widget.maxLength,
              decoration: InputDecoration(
                labelText: widget.labelText,
                hintText: widget.hintText,
                prefixIcon: const Icon(Icons.security),
                counterText: '',
              ),
              validator: widget.validator,
              enabled: !widget.isLoading,
            ),
            const HBox(24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: widget.isLoading ? null : _submitForm,
                child: widget.isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Подтвердить'),
              ),
            ),
            const HBox(16),
            TextButton(
              onPressed: widget.isLoading ? null : widget.onResendCode,
              child: const Text('Отправить код повторно'),
            ),
          ],
        ),
      ),
    );
  }
}
