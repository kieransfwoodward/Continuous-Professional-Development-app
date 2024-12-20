import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../functions/firebase_functions.dart';
import 'package:cpd/screens/quiz_screen.dart';
import 'package:cpd/widgets/lists/list_view_separator.dart';
import 'package:cpd/functions/firebase_functions.dart';


// class interact_image extends StatelessWidget {
//   const interact_image({Key? key}) : super(key: key);
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

class interact_m3image_collab extends StatefulWidget {
  const interact_m3image_collab({Key? key,
    required this.moduleId,
    required this.questionNumber,
    required this.data,
  }) : super(key: key);

  final String moduleId;
  final String questionNumber;
  final Map<String, dynamic> data;

  @override
  _interact_m3image_collab createState() => _interact_m3image_collab();
}


class _interact_m3image_collab extends State<interact_m3image_collab> {

  bool ticked = false;
  String example1 = "";

  void setSample(String tobecome) {

    setState(() {
      example1 = tobecome;
    });
  }

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
    int page = QuizScreen.of(context)!.currentPageIndex +1;
    FirebaseFirestore.instance
        .collection("modules")
        .doc(name1).collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid).set({
      "progress": page,
    },
      SetOptions(merge:true),
    );

  }

  AlertDialog alert1 = const AlertDialog(
    title: Text("Opportunity"),
    content: Text("The lack of opportunity to pull together collective experience."),
    actions: [
      //okButton,
    ],
  );
  AlertDialog alert2 = const AlertDialog(
    title: Text("Time"),
    content: Text("No time to reflect and learn."),
    actions: [
      //okButton,
    ],
  );
  AlertDialog alert3 = const AlertDialog(
    title: Text("Lessons-learned"),
    content: Text("No connection between lessons-learned and the work on site."),
    actions: [
      //okButton,
    ],
  );
  AlertDialog alert4 = const AlertDialog(
    title: Text("Experience"),
    content: Text("Not using past experience to improve processes."),
    actions: [
      //okButton,
    ],
  );
  AlertDialog alert5 = const AlertDialog(
    title: Text("Selfishness"),
    content: Text("Only caring about your own trade."),
    actions: [
      //okButton,
    ],
  );
  AlertDialog alert6 = const AlertDialog(
    title: Text("Ignored"),
    content: Text("Solutions and suggestions ignored."),
    actions: [
      //okButton,
    ],
  );
  AlertDialog alert7 = const AlertDialog(
    title: Text("Habits"),
    content: Text("Reacting with habits and emotions rather than analytical thinking."),
    actions: [
      //okButton,
    ],
  );


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: buildMaterialColor(HexColor("#d47828"))),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert2;
                        },
                      );
                    },
                    child: Text('Time'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: buildMaterialColor(HexColor("#d47828"))),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert1;
                        },
                      );
                    },
                    child: Text('Opportunity'),

                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: buildMaterialColor(HexColor("#d47828"))),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert3;
                        },
                      );
                    },
                    child: Text('Lessons-learned'),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Center(
                      child: Image.asset('assets/Module_3_ReasonsAlt.PNG',
                          //height: 400,
                          width: screenWidth * 0.6,
                          ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: buildMaterialColor(HexColor("#d47828"))),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert4;
                        },
                      );
                    },
                    child: Text('Experience'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: buildMaterialColor(HexColor("#d47828"))),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert5;
                        },
                      );
                    },
                    child: Text('Selfishness'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 3),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: buildMaterialColor(HexColor("#d47828"))),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert6;
                          },
                        );
                      },
                      child: Text('Ignored'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 3),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: buildMaterialColor(HexColor("#d47828"))),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert7;
                          },
                        );
                      },
                      child: Text('Habits'),
                    ),
                  ),
                ],
              ),
              const ListViewSeparator(),
              CheckboxListTile(
                title: const Text('Save progress'),
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
            ], //<Widget>[]
          ), //Column
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
    return MaterialColor(color.value, swatch);}
}
