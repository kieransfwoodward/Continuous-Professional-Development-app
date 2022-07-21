import 'package:flutter/material.dart';

// Separator between list items

class ListViewSeparator extends StatelessWidget {
  const ListViewSeparator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Divider(
        color: Theme.of(context).primaryColorLight,
      ),
    );
  }
}
