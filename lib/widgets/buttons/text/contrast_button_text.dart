import 'package:flutter/material.dart';

// Button text, same colour as the app canvas

class ContrastButtonText extends StatelessWidget {
  const ContrastButtonText({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.subtitle1?.copyWith(
            color: Theme.of(context).canvasColor,
          ),
      textAlign: TextAlign.center,
    );
  }
}
