import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String validateText;
  final String fieldName;
  final bool? obscureText; // Tornando obscureText opcional

  CustomTextFormField({
    Key? key,
    required this.controller,
    required this.validateText,
    required this.fieldName,
    this.obscureText,
  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _showError = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obscureText ?? false, // Usando o valor fornecido ou false como padrão
      decoration: InputDecoration(
        hintText: widget.fieldName,
        labelText: widget.fieldName,
        errorText: _showError ? widget.validateText : null,
        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return widget.validateText;
        }
        return null;
      },
    );
  }
}
