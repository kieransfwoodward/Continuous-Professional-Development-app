import 'package:cpd/widgets/app_bars/progress_widgets/progress_item.dart';
import 'package:flutter/material.dart';

class ProgressWidgets extends StatelessWidget {
  const ProgressWidgets({
    Key? key,
    required this.crossAxisAlignment,
  }) : super(key: key);
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: const [
        ProgressItem(
          icon: Icons.star,
          collectionRefName: "activity",
          docRefName: "progress",
          field: "current_points",
          textToInclude: null,
          returnValIfNull: 0,
        ),
        Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: ProgressItem(
            icon: Icons.emoji_events,
            collectionRefName: "activity",
            docRefName: "progress",
            field: "level",
            textToInclude: null,
            returnValIfNull: 1,
          ),
        )
      ],
    );
  }
}
