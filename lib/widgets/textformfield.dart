import 'package:flutter/material.dart';

customTextFormField({
  required TextEditingController controller,
  required TextInputType keytype,
  required String hint,
  required validate,
  required IconData preicon,
  IconData? suffix,
  suffixtap,
  bool secure = false,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: keytype,
      decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(preicon),
          suffixIcon: IconButton(
            icon: Icon(suffix),
            onPressed: suffixtap,
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.blue))),
      validator: validate,
      obscureText: secure,
    );
