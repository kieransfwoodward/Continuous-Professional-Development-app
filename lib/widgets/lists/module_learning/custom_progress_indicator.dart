import 'package:flutter/material.dart';

// TODO: This needs finishing - future builder
// TODO: Replace green circle with tick

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 12,
      height: 12,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        value: 1,
        color: Colors.green,
        backgroundColor: Theme.of(context).secondaryHeaderColor,
      ),
    );
  }
}
