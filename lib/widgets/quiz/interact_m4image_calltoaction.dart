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

class interact_m4image_calltoaction extends StatefulWidget {
  const interact_m4image_calltoaction({Key? key,
    required this.moduleId,
    required this.questionNumber,
    required this.data,
  }) : super(key: key);

  final String moduleId;
  final String questionNumber;
  final Map<String, dynamic> data;

  @override
  _interact_m4image_calltoaction createState() => _interact_m4image_calltoaction();
}


class _interact_m4image_calltoaction extends State<interact_m4image_calltoaction> {

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
    if(name1 == "Module 1"){
      FirebaseFunctions().Module1.update({
        "progress": page,
      });
    }
    if(name1 == "Module 2"){
      FirebaseFunctions().Module2.update({
        "progress": page,
      });
    }
    if(name1 == "Module 3"){
      FirebaseFunctions().Module3.update({
        "progress": page,
      });
    }
    if(name1 == "Module 4"){
      FirebaseFunctions().Module4.update({
        "progress": page,
      });
    }

  }

  AlertDialog alert1 = const AlertDialog(
    title: Text('1. Develop'),
    content: Text("Do it taking small steps. Develop an idea and think critically. Remember to stay clear of "
        "group-think and keep challenging the idea. Ask difficult questions and different perspectives. There "
        "are many drivers for innovation. You may engage with clients and manufacturers or consider the "
        "structure of construction. Think about the process flows. Draw on the relationships between individuals "
        "and firms within the industry and between the industry and external parties. How might they see the "
        "situation?"),
    actions: [
      //okButton,
    ],
  );
  AlertDialog alert2 = const AlertDialog(
    title: Text("2. Learn"),
    content: Text("Learning is a central aspect of ongoing development and this applies to innovation too. "
        "You may face specific challenges that may hinder the opportunities for thinking about innovation, "
        "for example, project and work opportunities, skills shortages, increased material and setup costs, "
        "energy and power usage and so on. All these challenges present opportunities for learning and innovation." ),
    actions: [
      //okButton,
    ],
  );
  AlertDialog alert3 = const AlertDialog(
    title: Text("5. Generate"),
    content: Text("Innovation is an ongoing process and often you need to generate different possibilities and refine "
        "knowledge as you go along. Keep going back to developing the idea, learning, refining, testing and experimenting. "
        "Remember there are many different ways of adding value, financial, social and environmental for example, and "
        "there are many different ways of innovating. Think about processes, products, people and beyond."),
    actions: [
      //okButton,
    ],
  );
  AlertDialog alert4 = const AlertDialog(
    title: Text("3. Refine"),
    content: Text("Then refine the idea. Think about how you can try and overcome the challenges."),
    actions: [
      //okButton,
    ],
  );
  AlertDialog alert5 = const AlertDialog(
    title: Text("4. Test"),
    content: Text("When it’s time to test the idea and experiment how things work in practice, "
        "keep an open mind and remain reflexive and critical."),
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
                    child: Text('1. Develop'),
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
                    child: Text('2. Learn'),
                  ),
                ],
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Center(
                      child: Image.asset('assets/Module_4_CallAlt.PNG',
                          //height: 400,
                          width: screenWidth * 0.8,
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
                          return alert3;
                        },
                      );
                    },
                    child: Text('5. Generate'),
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
                    child: Text('3. Refine'),
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
                          return alert5;
                        },
                      );
                    },
                    child: Text('4. Test'),
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