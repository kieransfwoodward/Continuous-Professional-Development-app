import 'package:cpd/screens/leaderboard_screen.dart';
import 'package:cpd/widgets/app_bars/progress_widgets/progress_widgets.dart';
import 'package:cpd/widgets/buttons/app_bar_button.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';


// App bar for the home page

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
    Widget build(BuildContext context) {
      AlertDialog alert1 = const AlertDialog(
        title: Text("Points"),
        content: Text("To earn points, play through each of the modules."
            "\n\nCheck out the leaderboard to see how you compare to other users."),
        actions: [
          //okButton,
        ],
      );


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
              GestureDetector(
                child: const ProgressWidgets(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
              // GestureDetector(
              //   child: Icon(
              //     Icons.info_outline,
              //     size: 30,
              //     color: buildMaterialColor(HexColor("#d47828")),
              //   ),
              //   onTap: () {
              //     showDialog(
              //       context: context,
              //       builder: (BuildContext context) {
              //         return alert2;
              //       },
              //     );
              //   },
              // ),
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
            padding: const EdgeInsets.only(top:15.0, bottom: 4.0),
            child: Text(
              "Four short CPD modules as part of the Innovation "
                  "Driven Procurement project – for construction site "
                  "workers. These modules have been co-created by "
                  "sub-contractors.",
              style: Theme.of(context).textTheme.overline?.copyWith(
                color: const Color(0xffd47828),
                fontSize: 14,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:4.0, bottom: 2.0),
            child: Text(
              "What will your CPD be today?",
              style: Theme.of(context).textTheme.headline6?.copyWith(
                color: const Color(0xffd47828),
              ),
            ),

          ),
        ],
      ),
    );
  }
  buildMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    };
    return MaterialColor(color.value, swatch);
  }
}
