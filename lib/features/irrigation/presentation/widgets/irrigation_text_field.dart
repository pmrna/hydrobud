import 'package:flutter/material.dart';
import 'package:hydrobud/core/theme/pallete.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final Color backgroundColor;
  final Color borderColor;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.backgroundColor,
    required this.borderColor,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          labelText,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: TextFormField(
            keyboardType: TextInputType.number,
            controller: controller,
            style: const TextStyle(
                color: AppPallete.textColorBlack, fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(color: AppPallete.unfocusColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: borderColor,
                  width: 2.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: borderColor,
                  width: 2.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: borderColor,
                  width: 2.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
