import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {Key? key,
      required this.inputTitle,
      this.enabled = true,
      this.controller})
      : super(key: key);

  String inputTitle;
  bool enabled;
  TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
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
              return 'Campo obrigatório';
            }
          }

          return null;
        },
      ),
    );
  }
}
