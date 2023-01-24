import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cpd/screens/quiz_screen.dart';
import 'package:cpd/widgets/buttons/quiz/question_options/question_list_option.dart';
import 'package:cpd/widgets/image/module_banner_image.dart';
import 'package:cpd/widgets/lists/list_view_separator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cpd/functions/firebase_functions.dart';
import 'package:hexcolor/hexcolor.dart';

// Multiple choice question sheet, with the focus being the image

//TODO: Save completion of question

class SingleMultipleChoiceQuestion extends StatefulWidget {
  const SingleMultipleChoiceQuestion({
    Key? key,
    required this.moduleId,
    required this.questionNumber,
    required this.data,
  }) : super(key: key);

  final String moduleId;
  final String questionNumber;
  final Map<String, dynamic> data;

  @override
  State<SingleMultipleChoiceQuestion> createState() =>
      _SingleMultipleChoiceQuestionState();
}

class _SingleMultipleChoiceQuestionState
    extends State<SingleMultipleChoiceQuestion> {

  AlertDialog alert1 = const AlertDialog(
    title: Text("Multiple Choice Activities"),
    content: Text("Carefully read the question and available answers.\n\n"
        "When you are ready, touch the answer you think is correct. If you're right "
        "the box will glow green and you will earn 10 points.\n\n"
        "Don't worry if you get it wrong, the text that appears after will help "
        "develop your knowledge and there are plenty more opportunities to build "
        "your score."),
    actions: [
      //okButton,
    ],
  );

  int _groupOptionVal = 1;
  bool _optionSelected = false;

  Future<void> _updatePoints() async {
    if (widget.data["correct_answer"] == _groupOptionVal) {
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

        String name1 = QuizScreen.of(context)!.moduleName;


          FirebaseFirestore.instance
              .collection("modules")
              .doc(name1).collection("users")
              .doc(FirebaseAuth.instance.currentUser!.uid).get().then((doc) {
            if (doc.data() != null) {
              int correct =
                  (doc.data() as Map<String, dynamic>)["correct"] ?? 0;
              FirebaseFirestore.instance
                  .collection("modules")
                  .doc(name1).collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.uid).set({
                "correct": correct + 1,

              });
            }
          });


        // QuizScreen.of(context)!.points =
        //     QuizScreen.of(context)!.finalPoints + (widget.data["points"] as int);
      }
    }

    String name1 = QuizScreen.of(context)!.moduleName;
    int page = QuizScreen.of(context)!.currentPageIndex +1;
    FirebaseFirestore.instance
        .collection("modules")
        .doc(name1).collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid).set({
      "progress": page,
    });

  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 16.0,
              bottom: 4.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.data["question_title"],
                  style: Theme.of(context).textTheme.headline5,
                ),
                GestureDetector(
                  child: Icon(
                    Icons.info_rounded,
                    size: 32,
                    color: buildMaterialColor(HexColor("#d47828")),
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
          Text(
            widget.data["question_subtitle"],
            style: Theme.of(context).textTheme.subtitle1,
          ),
          const ListViewSeparator(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: (widget.data["answers"] as LinkedHashMap)
                .entries
                .map((e) => QuestionListOption(
                      value: int.parse(e.key),
                      onTap: () {
                        !_optionSelected
                            ? setState(() {
                                _optionSelected = true;
                                _groupOptionVal = int.parse(e.key);
                              })
                            : null;
                        _updatePoints();
                      },
                      text: e.value,
                      correctAnswer: widget.data["correct_answer"],
                      optionTapped: _optionSelected,
                      groupValue: _groupOptionVal,
                    ))
                .toList(),
          ),
          if(_optionSelected)Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(widget.data["feedback"]),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 70.0),
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
    return MaterialColor(color.value, swatch);}
}
