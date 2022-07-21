import 'package:cpd/styling/custom_border.dart';
import 'package:cpd/widgets/image/module_banner_image.dart';
import 'package:flutter/material.dart';

// TODO: Finish this

class LeaderboardItem extends StatelessWidget {
  LeaderboardItem({
    Key? key,
    this.position,
    required this.imageUrl,
    required this.name,
    required this.level,
    required this.points,
    required this.currentUser,
  }) : super(key: key);
  int? position;
  final int points, level;
  final String imageUrl, name;
  final bool currentUser;

  String _checkPositionLength() {
    return position.toString().split("").length == 1
        ? "#0$position"
        : "#$position";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
      currentUser ? CustomBorder().leaderboardDecoration(context) : null,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 48,
                  child: Text(
                    _checkPositionLength(),
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: ModuleBannerImage(
                    imagePath: imageUrl,
                    imageType: ImageType.leaderboard,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                    Text(
                      "Level $level",
                      style: Theme.of(context).textTheme.subtitle2?.copyWith(
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              "$points",
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
