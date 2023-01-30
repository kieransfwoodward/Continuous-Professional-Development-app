import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cpd/screens/quiz_screen.dart';
import 'package:cpd/styling/size_params.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cpd/functions/firebase_functions.dart';

// Finished quiz page - show completion

class FinishedQuizPage extends StatelessWidget {
  const FinishedQuizPage({
    Key? key,
  }) : super(key: key);

  String _getModuleName(BuildContext context) {
    if (QuizScreen.of(context) != null) {
      return QuizScreen.of(context)!.moduleName;
    }
    return "Unknown Module";
  }

  int _getPoints(BuildContext context) {
    QuizScreen.of(context)?.points();

    if (QuizScreen.of(context) != null) {

      String name1 = QuizScreen.of(context)!.moduleName;
      int page = QuizScreen.of(context)!.currentPageIndex +1;
      FirebaseFirestore.instance
          .collection("modules")
          .doc(name1).collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid).set({
        "completed": false,
      },
        SetOptions(merge:true),
      );





    }

    return QuizScreen.of(context)!.finalPoints;
    return 999;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: SizeParams().quarterHeight(context) * 3,
        width: SizeParams().quarterWidth(context) * 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Image.asset(
                'assets/logoAlt.PNG',
                width: 200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Text(
                "Congratulations!\n\nYou've finished ${_getModuleName(context)}",
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                "If you got over 80% correct the module will be marked as complete.",
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
