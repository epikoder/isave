import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

enum InputType { text, password }

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required this.label,
    this.controller,
    this.placeholder = '',
    this.inputType = InputType.text,
    this.validator,
    this.maxLenght,
    this.keyboardType,
    this.autovalidateMode,
    this.onChanged,
  });

  final String label;
  final TextEditingController? controller;
  final String placeholder;
  final InputType inputType;
  final String? Function(String?)? validator;
  final int? maxLenght;
  final TextInputType? keyboardType;
  final AutovalidateMode? autovalidateMode;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: inputType == InputType.password,
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 14, color: Colors.white),
      validator: validator,
      onChanged: onChanged,
      autovalidateMode: autovalidateMode,
      maxLength: maxLenght,
      decoration: InputDecoration(
        label: Styled.text(label).fontSize(16).padding(horizontal: 10),
        labelStyle: const TextStyle(color: Colors.white),
        hintText: placeholder,
        counter: const SizedBox(),
        hintStyle: const TextStyle(color: Colors.white70),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ).padding(horizontal: 20, vertical: 10);
  }
}
