import 'package:cpd/styling/custom_border.dart';
import 'package:flutter/material.dart';

// Menu button

class AppBarButton extends StatelessWidget {
  const AppBarButton({
    Key? key,
    required this.icon,
    required this.onTap,
  }) : super(key: key);
  final Function() onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: CustomBorder().borderRadius,
      child: Container(
        decoration: CustomBorder().optionsIconDecoration(context),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Icon(
            icon,
            color: const Color(0xffd47828),
            size: 18,
          ),
        ),
      ),
    );
  }
}
