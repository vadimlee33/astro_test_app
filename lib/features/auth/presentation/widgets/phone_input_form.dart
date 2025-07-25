import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/ui_kit/app_box.dart';

class PhoneInputForm extends StatefulWidget {
  final String title;
  final String labelText;
  final String hintText;
  final String? Function(String?)? validator;
  final void Function(String)? onPhoneChanged;
  final VoidCallback? onSubmit;
  final bool isLoading;
  final int maxLength;

  const PhoneInputForm({
    super.key,
    required this.title,
    required this.labelText,
    required this.hintText,
    required this.validator,
    required this.onPhoneChanged,
    required this.onSubmit,
    required this.isLoading,
    required this.maxLength,
  });

  @override
  _PhoneInputFormState createState() => _PhoneInputFormState();
}

class _PhoneInputFormState extends State<PhoneInputForm> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit?.call();
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
            const HBox(32),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(widget.maxLength),
              ],
              decoration: InputDecoration(
                labelText: widget.labelText,
                hintText: widget.hintText,
                prefixIcon: const Icon(Icons.phone),
              ),
              validator: widget.validator,
              enabled: !widget.isLoading,
              onChanged: widget.onPhoneChanged,
            ),
            const HBox(24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: widget.isLoading ? null : _submitForm,
                child: widget.isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Отправить код'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
