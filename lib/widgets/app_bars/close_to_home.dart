import 'package:flutter/material.dart';

// Button to take the user to the home page

class CloseToHome extends StatelessWidget {
  const CloseToHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      visualDensity: const VisualDensity(
        vertical: -4,
        horizontal: -4,
      ),
      onPressed: () => Navigator.of(context).popUntil(
        (route) => route.isFirst,
      ),
      icon: Icon(
        Icons.close,
        size: 36,
        color: Theme.of(context).canvasColor,
      ),
    );
  }
}