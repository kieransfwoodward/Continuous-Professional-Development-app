import 'package:cpd/widgets/app_bars/close_to_home.dart';
import 'package:cpd/widgets/lists/module_learning/module_tile_details.dart';
import 'package:flutter/material.dart';

// App bar for the module content

class ModuleContentAppBar extends StatelessWidget {
  const ModuleContentAppBar({
    Key? key,
    required this.duration,
    required this.points,
  }) : super(key: key);
  final int duration, points;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16.0,
        left: 16.0,
        right: 16,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CloseToHome(),
          ModuleTileDetails(
            duration: duration,
            points: points,
            largeItem: true,
          ),
        ],
      ),
    );
  }
}
