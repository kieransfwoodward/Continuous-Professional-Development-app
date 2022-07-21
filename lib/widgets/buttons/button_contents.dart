import 'package:cpd/styling/custom_border.dart';
import 'package:flutter/material.dart';

// The contents of the buttons, including the functionality to make the button clickable

class ButtonContents extends StatelessWidget {
  const ButtonContents({
    Key? key,
    required this.onTap,
    required this.child,
  }) : super(key: key);
  final Function() onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: CustomBorder().borderRadius,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
