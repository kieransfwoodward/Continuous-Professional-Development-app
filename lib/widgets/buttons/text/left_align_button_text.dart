import 'package:flutter/material.dart';

// Button text, same colour as the app theme

class LeftAlignButtonText extends StatelessWidget {
  const LeftAlignButtonText({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.subtitle1,
      textAlign: TextAlign.left,
    );
  }
}
