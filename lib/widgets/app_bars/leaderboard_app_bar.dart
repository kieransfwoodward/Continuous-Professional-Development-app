import 'package:cpd/widgets/app_bars/close_to_home.dart';
import 'package:flutter/material.dart';

// App bar to the leaderboard page
AlertDialog alert1 = const AlertDialog(
  title: Text("Leaderboard"),
  content: Text("Play through the modules in order to score points and compete with "
      "other users.\n\n"
      "Successfully completing various activities such as multiple choice, true/ false "
      "and drag & drop will give you points to build your score."
  ),
  actions: [
    //okButton,
  ],
);

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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 100.0),
                  child: Text(
                    "Leaderboard",
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: const Color(0xffd47828),
                        ),
                  ),
                ),
                GestureDetector(
                    child: const Icon(
                      Icons.info_rounded,
                      size: 32,
                      color: Color(0xffd47828),
                    ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert1;
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
