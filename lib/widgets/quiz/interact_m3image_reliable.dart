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

class interact_m3image_reliable extends StatefulWidget {
  const interact_m3image_reliable({Key? key,
    required this.moduleId,
    required this.questionNumber,
    required this.data,
  }) : super(key: key);

  final String moduleId;
  final String questionNumber;
  final Map<String, dynamic> data;

  @override
  _interact_m3image_reliable createState() => _interact_m3image_reliable();
}


class _interact_m3image_reliable extends State<interact_m3image_reliable> {

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
    title: Text('You can say "no"'),
    content: Text("Parties can say “no” to a request if it is not possible to achieve."),
    actions: [
      //okButton,
    ],
  );
  AlertDialog alert2 = const AlertDialog(
    title: Text("Take responsibility"),
    content: Text('Take responsibility and not walk away saying ”It’s not my problem”.'),
    actions: [
      //okButton,
    ],
  );
  AlertDialog alert3 = const AlertDialog(
    title: Text("Be honest"),
    content: Text("Everyone should be honest about their competence or access to the required "
        "competence for the task."),
    actions: [
      //okButton,
    ],
  );
  AlertDialog alert4 = const AlertDialog(
    title: Text("Accurate Assessment"),
    content: Text("The one promising should be able to accurately assess how long the task "
        "will take."),
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    child: Text('You can say "no"'),
                  ),
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
                    child: Text('Take responsibility'),
                  ),
                ],
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Center(
                      child: Image.asset('assets/Module_3_GroundRules.PNG',
                          //height: 400,
                          width: screenWidth * 0.6,
                          ),
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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
                    child: Text('Be honest'),
                  ),
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
                    child: Text('Acurrate Assesment'),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                    'By following these rules, problems can be raised early so that where possible,'
                    ' solutions can be sought.',
                  textAlign: TextAlign.center ,
                ),
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
