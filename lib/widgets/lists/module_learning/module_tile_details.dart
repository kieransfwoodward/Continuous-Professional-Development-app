import 'package:cpd/widgets/lists/module_learning/descriptive_icon.dart';
import 'package:flutter/material.dart';

// Module Tile

class ModuleTileDetails extends StatelessWidget {
  const ModuleTileDetails({
    Key? key,
    required this.duration,
    required this.points,
    required this.largeItem,
  }) : super(key: key);
  final int duration, points;
  final bool largeItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        DescriptiveIcon(
          leadingIcon: Icons.access_time,
          trailingText: "$duration min",
          isLargeItem: largeItem,
        ),
        Padding(
          padding: EdgeInsets.only(
            left: largeItem ? 16.0 : 8.0,
          ),
          child: DescriptiveIcon(
            leadingIcon: Icons.star_outline,
            trailingText: "$points xp",
            isLargeItem: largeItem,
          ),
        ),
      ],
    );
  }
}
