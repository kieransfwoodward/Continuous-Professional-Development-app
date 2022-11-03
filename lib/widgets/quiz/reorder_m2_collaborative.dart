import 'dart:math';

import 'package:cpd/screens/quiz_screen.dart';
import 'package:cpd/widgets/lists/list_view_separator.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../functions/firebase_functions.dart';

// void main() => runApp(const ReorderableApp());

// class ReorderableApp extends StatelessWidget {
//   const ReorderableApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         // appBar: AppBar(title: const Text('ReorderableListView Sample')),
//         body: const ReorderableExample(),
//       ),
//     );
//   }
// }

class reorder_m2_collaborative extends StatefulWidget {
  const reorder_m2_collaborative({
    Key? key,
    required this.moduleId,
    required this.questionNumber,
    required this.data,
  }) : super(key: key);

  final String moduleId;
  final String questionNumber;
  final Map<String, dynamic> data;

  @override
  State<reorder_m2_collaborative> createState() => _reorder_m2_collaborative();
}

class _reorder_m2_collaborative extends State<reorder_m2_collaborative> {
  final ScrollController reorderScrollController = ScrollController();
  bool ticked = false;

  Future<void> _updatePoints() async {
    if (QuizScreen.of(context) != null) {
      FirebaseFunctions().user.get().then((doc) {
        if (doc.data() != null) {
          int points =
              (doc.data() as Map<String, dynamic>)["current_points"] ?? 0;
          FirebaseFunctions().user.update({
            "current_points": points + widget.data["points"] as int,
          });
        }
      });

      // QuizScreen.of(context)!.points =
      //     QuizScreen.of(context)!.finalPoints + (widget.data["points"] as int);
    }

    String name1 = QuizScreen.of(context)!.moduleName;
    int page = QuizScreen.of(context)!.currentPageIndex + 1;
    if (name1 == "Module 1") {
      FirebaseFunctions().Module1.update({
        "progress": page,
      });
    }
    if (name1 == "Module 2") {
      FirebaseFunctions().Module2.update({
        "progress": page,
      });
    }
    if (name1 == "Module 3") {
      FirebaseFunctions().Module3.update({
        "progress": page,
      });
    }
    if (name1 == "Module 4") {
      FirebaseFunctions().Module4.update({
        "progress": page,
      });
    }
  }

  List<String> titles = [
    "Conflict Resolution",
    "Emotional Intellegence",
    "Open-Mindedness",
    "Adoptability",
    "Organisation",
    "Active Listening",
    "Communication",
  ];

  List<String> subtitles = [
    "Individuals are giving their opinion and judgments on the situation.",
    "You are relaying information from someone else, not owning the conversation.",
    "Moves away from facts, rituals and safe subjects to explore hopes, fears, feelings and passions.",
    "Where you pass the time of day, or talk about safe subjects such as "
        "weather, sports, or TV.",
    "Someone is prepared to say what they think and feel.",
    "Individuals are giving their opinion and judgments on the situation.",
    "You are relaying information from someone else, not owning the conversation.",
  ];

  List<String> indexList = [
    "Most",
    "",
    "",
    "Middle",
    "",
    "",
    "Least",
  ];

  @override
  Widget build(BuildContext context) {
    // final ColorScheme colorScheme = Theme.of(context).colorScheme;
    // final Color oddItemColor = buildMaterialColor(HexColor("#d47828"));
    // final Color evenItemColor = buildMaterialColor(HexColor("#384a5f"));

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: 16.0,
              bottom: 4.0,
            ),
            child: Text(
              widget.data["question_title"],
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          const ListViewSeparator(),
          Text(
            widget.data["question_subtitle"],
            style: Theme.of(context).textTheme.subtitle1,
          ),
          ReorderableListView.builder(
              itemCount: titles.length,
              shrinkWrap: true,
              scrollController: reorderScrollController,
              itemBuilder: (context, index) {
                final String productName = titles[index];
                return Card(
                  key: ValueKey(productName),
                  color: buildMaterialColor(HexColor("#d47828")),
                  elevation: 1,
                  margin: const EdgeInsets.all(5),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(2),
                    title: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${productName}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                            ),
                            Transform.rotate(
                              angle: 90 * pi / 180,
                              child: const Icon(
                                Icons.multiple_stop_rounded,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    // subtitle: Text(
                    //   "${subtitles[index]}",
                    // ),
                    leading: Text(
                      "${indexList[index]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  if (newIndex > oldIndex) {
                    newIndex = newIndex - 1;
                  }
                  final element = titles.removeAt(oldIndex);
                  titles.insert(newIndex, element);
                });
              }),
          const ListViewSeparator(),
          CheckboxListTile(
            title: const Text('I am happy with my order'),
            value: ticked,
            onChanged: (bool? value) {
              setState(() {
                ticked = true;
                _updatePoints();
              });
            },
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 80.0),
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
    }
    ;
    return MaterialColor(color.value, swatch);
  }
}
