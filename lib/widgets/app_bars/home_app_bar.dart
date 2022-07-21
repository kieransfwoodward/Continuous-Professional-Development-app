import 'package:cpd/functions/firebase_functions.dart';
import 'package:cpd/screens/leaderboard_screen.dart';
import 'package:cpd/screens/profile_screen.dart';
import 'package:cpd/screens/welcome_screen.dart';
import 'package:cpd/widgets/app_bars/progress_widgets/progress_widgets.dart';
import 'package:cpd/widgets/buttons/app_bar_button.dart';
import 'package:flutter/material.dart';

// App bar for the home page

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16.0,
        left: 16.0,
        right: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const ProgressWidgets(
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
              Row(
                children: [
                  AppBarButton(
                    icon: Icons.leaderboard,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LeaderboardScreen(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: AppBarButton(
                      icon: Icons.person,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileScreen(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 2.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.emoji_people,
                  color: Theme.of(context).canvasColor,
                  size: 12,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: FirebaseFunctions().getFieldByDocId(
                    ref: FirebaseFunctions().user,
                    field: "first_name",
                    returnValIfNull: "",
                    prefixText: "Welcome ",
                    style: Theme.of(context).textTheme.overline?.copyWith(
                          color: Theme.of(context).canvasColor,
                        ),
                  ),
                )
              ],
            ),
          ),
          Text(
            "What will your CPD be today?",
            style: Theme.of(context).textTheme.headline6?.copyWith(
                  color: Theme.of(context).canvasColor,
                ),
          ),
        ],
      ),
    );
  }
}
