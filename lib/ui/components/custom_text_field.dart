import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {Key? key,
      required this.inputTitle,
      this.enabled = true,
      this.controller,
      this.margin,
      this.textInputType,
      this.onNullMessage})
      : super(key: key);

  String inputTitle;
  bool enabled;
  TextEditingController? controller;
  double? margin;
  TextInputType? textInputType;
  String? onNullMessage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(margin ?? 10.0),
      child: TextFormField(
        keyboardType: (textInputType ?? TextInputType.text),
        controller: controller,
        decoration: InputDecoration(
          labelText: inputTitle,
          enabled: enabled,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        validator: (value) {
          if (enabled) {
            if (value == null || value.trim().isEmpty) {
              return (onNullMessage ?? 'Campo obrigatório');
            }
          }

          return null;
        },
      ),
    );
  }
}
