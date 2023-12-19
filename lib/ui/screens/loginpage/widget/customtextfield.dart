import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
   String? initialValue;

   CustomTextField({
    Key? key,
    required this.labelText,
     this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: TextField(
        style: const TextStyle(fontSize: 23),
        controller: TextEditingController(text: initialValue),
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}