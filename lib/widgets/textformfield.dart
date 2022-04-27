import 'package:flutter/material.dart';

CustomTextFormField({
  required TextEditingController Controller,
  required TextInputType keytype,
  required String hint,
  required validate,
  required IconData preicon,
  IconData? suffix,
  suffixtap,
  bool secure = false,
}) =>
    TextFormField(
      controller: Controller,
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
              borderSide: BorderSide(color: Colors.blue))),
      validator: validate,
      obscureText: secure,
    );
