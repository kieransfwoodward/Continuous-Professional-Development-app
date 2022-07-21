import 'package:cpd/widgets/app_bars/close_to_home.dart';
import 'package:flutter/material.dart';

// App bar to the leaderboard page

class LeaderboardAppBar extends StatelessWidget {
  const LeaderboardAppBar({Key? key}) : super(key: key);

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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const CloseToHome(),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              "Leaderboard",
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    color: Theme.of(context).canvasColor,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
