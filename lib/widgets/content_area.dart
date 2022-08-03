import 'package:cpd/styling/custom_border.dart';
import 'package:flutter/material.dart';

// Denotes the white box where content resides

class ContentArea extends StatelessWidget {
  const ContentArea({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 16,
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: CustomBorder().topOnlyBorder,
        ),
        clipBehavior: Clip.hardEdge,
          padding: const EdgeInsets.only(
            left: 8.0,
            right: 8.0,
            top: 8,
          ),
        child: child
          // margin: const EdgeInsets.all(64.0),
          // child: Expanded(
          //   child: child,
          // ),
        // ),
      ),
    );
  }
}
