import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cpd/screens/quiz_screen.dart';
import 'package:cpd/widgets/buttons/quiz/question_options/question_list_option.dart';
import 'package:cpd/widgets/image/module_banner_image.dart';
import 'package:cpd/widgets/lists/list_view_separator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cpd/functions/firebase_functions.dart';


// Multiple choice question sheet, with the focus being the image

//TODO: Save completion of question

class CheckUnderstanding extends StatefulWidget {
  const CheckUnderstanding({
    Key? key,
    required this.moduleId,
    required this.questionNumber,
    required this.data,
  }) : super(key: key);

  final String moduleId;
  final String questionNumber;
  final Map<String, dynamic> data;

  @override
  State<CheckUnderstanding> createState() =>
      _CheckUnderstanding();
}

class _CheckUnderstanding
    extends State<CheckUnderstanding> {
  int _groupOptionVal = 1;
  bool _optionSelected = false;
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
              bottom: 8.0,
            ),
            child: Text(
              widget.data["question_title"],
              style: Theme.of(context).textTheme.headline5,
            ),
          ),

          ModuleBannerImage(
            imagePath: widget.data["image_url"],
            imageType: ImageType.banner4,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 16.0,
              bottom: 4.0,
            ),
            child: Text(
              widget.data["question_subtitle"],
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          const ListViewSeparator(),
          CheckboxListTile(
            title: const Text("I'm ready to continue"),
            value: ticked,
            onChanged: (bool? value) {
              setState(() {
                ticked = true;
                _updatePoints();
              });
            },
          ),

          Padding(
            padding: EdgeInsets.only(bottom: 70.0),
          ),

        ],
      ),
    );
  }
}
