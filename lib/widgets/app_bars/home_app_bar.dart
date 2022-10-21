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
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 16.0),
                  //   child: AppBarButton(
                  //     icon: Icons.person,
                  //     onTap: () => Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => const ProfileScreen(),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top:12.0, bottom: 4.0),
            child: Text(
              "What will your CPD be today?",
              style: Theme.of(context).textTheme.headline6?.copyWith(
                color: const Color(0xffd47828),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:4.0, bottom: 2.0),
            child: Text(
                "Four short CPD modules as part of the Innovation"
                            "Driven Procurement project – for construction site"
                            "workers. The modules have been co-created by"
                            "sub-contractors… hear their thoughts and comments"
                            "about collaborating and working together on site across"
                            "all trades, to make the job easier, and more productive"
                            "for everyone.",
                        style: Theme.of(context).textTheme.overline?.copyWith(
                          color: const Color(0xffd47828),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
