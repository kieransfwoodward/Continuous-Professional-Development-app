import 'dart:collection';

import 'package:cpd/screens/quiz_screen.dart';
import 'package:cpd/widgets/buttons/quiz/question_options/question_list_option.dart';
import 'package:cpd/widgets/image/module_banner_image.dart';
import 'package:cpd/widgets/lists/list_view_separator.dart';
import 'package:flutter/material.dart';
import 'package:cpd/functions/firebase_functions.dart';


// Multiple choice question sheet, with the focus being the image

//TODO: Save completion of question

class SingleImageMultipleChoiceQuestion extends StatefulWidget {
  const SingleImageMultipleChoiceQuestion({
    Key? key,
    required this.moduleId,
    required this.questionNumber,
    required this.data,
  }) : super(key: key);

  final String moduleId;
  final String questionNumber;
  final Map<String, dynamic> data;

  @override
  State<SingleImageMultipleChoiceQuestion> createState() =>
      _SingleImageMultipleChoiceQuestionState();
}

class _SingleImageMultipleChoiceQuestionState
    extends State<SingleImageMultipleChoiceQuestion> {
  int _groupOptionVal = 1;
  bool _optionSelected = false;

  Future<void> _updatePoints() async {
    if (widget.data["correct_answer"] == _groupOptionVal) {
      if (QuizScreen.of(context) != null) {

        FirebaseFunctions().user.get().then((doc) {
          if (doc.data() != null) {
            int points =
                (doc.data() as Map<String, dynamic>)["current_points"] ?? 99;
            FirebaseFunctions().user.update({
              "current_points": points + widget.data["points"] as int,

            });

          }
        });

        String name1 = QuizScreen.of(context)!.moduleName;

        if(name1 == "Module 1"){
          FirebaseFunctions().Module1.get().then((doc) {
            if (doc.data() != null) {
              int correct =
                  (doc.data() as Map<String, dynamic>)["correct"] ?? 99;
              FirebaseFunctions().Module1.update({
                "correct": correct + 1,

              });
            }
          });
        }
        if(name1 == "Module 2"){
          FirebaseFunctions().Module2.get().then((doc) {
            if (doc.data() != null) {
              int correct =
                  (doc.data() as Map<String, dynamic>)["correct"] ?? 99;
              FirebaseFunctions().Module2.collection("activity").doc("progress").update({
                "correct": correct + 1,

              });
            }
          });
        }
        if(name1 == "Module 3"){
          FirebaseFunctions().Module3.get().then((doc) {
            if (doc.data() != null) {
              int correct =
                  (doc.data() as Map<String, dynamic>)["correct"] ?? 99;
              FirebaseFunctions().Module3.collection("activity").doc("progress").update({
                "correct": correct + 1,

              });
            }
          });
        }
        if(name1 == "Module 4"){
          FirebaseFunctions().Module4.get().then((doc) {
            if (doc.data() != null) {
              int correct =
                  (doc.data() as Map<String, dynamic>)["correct"] ?? 99;
              FirebaseFunctions().Module4.collection("activity").doc("progress").update({
                "correct": correct + 1,

              });
            }
          });
        }








      //  QuizScreen.of(context)!.points =
      //      QuizScreen.of(context)!.finalPoints + (widget.data["points"] as int);
      }
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ModuleBannerImage(
            imagePath: widget.data["image_url"],
            imageType: ImageType.banner,
          ),
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
              Text(widget.data["feedback"])
            ],
          ),
        ],
      ),
    );
  }
}
