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
    AlertDialog alert1 = const AlertDialog(
      title: Text("Duration"),
      content: Text("To earn points, play through each of the modules."
          "\n\nCheck out the leaderboard to see how you compare to other users."),
      actions: [
        //okButton,
      ],
    );
    AlertDialog alert2 = const AlertDialog(
      title: Text("Points"),
      content: Text("To earn points, play through each of the modules."
          "\n\nCheck out the leaderboard to see how you compare to other users."),
      actions: [
        //okButton,
      ],
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // GestureDetector(
        //   child:
          DescriptiveIcon(
            leadingIcon: Icons.access_time,
            trailingText: "$duration min",
            isLargeItem: largeItem,
          ),
        //   onTap: () {
        //     showDialog(
        //       context: context,
        //       builder: (BuildContext context) {
        //         return alert1;
        //       },
        //     );
        //   },
        // ),
        Padding(
          padding: EdgeInsets.only(
            left: largeItem ? 16.0 : 8.0,
          ),
          child:
    // GestureDetector(
    //         child:
            DescriptiveIcon(
              leadingIcon: Icons.star_outline,
              trailingText: "$points xp",
              isLargeItem: largeItem,
            ),
          //   onTap: () {
          //     showDialog(
          //       context: context,
          //       builder: (BuildContext context) {
          //         return alert2;
          //       },
          //     );
          //   },
          // ),
        ),
      ],
    );
  }
}
