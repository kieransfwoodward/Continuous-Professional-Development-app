import 'dart:collection';

import 'package:cpd/screens/quiz_screen.dart';
import 'package:cpd/widgets/buttons/quiz/question_options/question_list_option.dart';
import 'package:cpd/widgets/image/module_banner_image.dart';
import 'package:cpd/widgets/lists/list_view_separator.dart';
import 'package:flutter/material.dart';
import 'package:cpd/functions/firebase_functions.dart';

// Multiple choice question sheet, with the focus being the image

//TODO: Save completion of question

class learn_text extends StatefulWidget {
  const learn_text({
    Key? key,
    required this.moduleId,
    required this.questionNumber,
    required this.data,
  }) : super(key: key);

  final String moduleId;
  final String questionNumber;
  final Map<String, dynamic> data;

  @override
  State<learn_text> createState() =>
      _learn_textState();
}

class _learn_textState
    extends State<learn_text> {
  int _groupOptionVal = 1;
  bool _optionSelected = false;
  bool ticked = false;

  @override
  initState(){
    _updatePoints();
    super.initState();
  }


  Future<void> _updatePoints() async {

      if (QuizScreen.of(context) != null) {
        FirebaseFunctions().user.collection("activity").doc("progress").get().then((doc) {
          if (doc.data() != null) {
            int points =
                (doc.data() as Map<String, dynamic>)["current_points"] ?? 99;
            FirebaseFunctions().user.collection("activity").doc("progress").set({
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
    if(name1 == "Module4 "){
      FirebaseFunctions().Module4.update({
        "progress": page,
      });
    }

  }

  @override
  Widget build(BuildContext context)
  {
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
          // Checkbox(
          //   checkColor: Colors.white,
          //   fillColor: MaterialStateProperty.resolveWith(Colors.blue),
          //   value: false,
          //   onChanged: (bool? value) {
          //     setState(() {
          //       _updatePoints()
          //     });
          //   },
          // ),
  CheckboxListTile(
  title: const Text('I have read it'),
  value: ticked,
  onChanged: (bool? value) {
  setState(() {
    ticked = true;
  _updatePoints();
  });
  },
  ),

          Padding(
            padding: EdgeInsets.only(bottom: 60.0),
          ),
        ],
      ),
    );
  }
}
