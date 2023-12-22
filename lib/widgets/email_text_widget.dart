import 'package:flutter/material.dart';

class EmailTextField extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const EmailTextField({Key? key, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Email',
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.emailAddress,
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        // Add a more comprehensive email validation if needed
        // For a basic check, you can use a regular expression
        if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(value)) {
          return 'Please enter a valid email address';
        }
        return null;
      },
    );
  }
}
