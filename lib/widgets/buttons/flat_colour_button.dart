import 'package:cpd/styling/custom_border.dart';
import 'package:cpd/widgets/buttons/button_contents.dart';
import 'package:flutter/material.dart';

import '../../screens/quiz_screen.dart';

// Flat button with the app theme colour

class FlatColourButton extends StatelessWidget {
  const FlatColourButton({
    Key? key,
    required this.onTap,
    required this.child,
    required this.width,
  }) : super(key: key);
  final Function() onTap;
  final Widget child;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: CustomBorder().roundedFilled(context),
      // Set the button size
      width: width,
      // Pass in the onTap method and the widget to show
      child: ButtonContents(
        onTap: onTap,
        child: child,
      ),
    );
  }
}
