import 'package:flutter/material.dart';

class CustomRoundedButton extends StatelessWidget {
  String text;
  Function onPressed;
  CustomRoundedButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => onPressed(),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text(text),
        )
    );
  }
}
