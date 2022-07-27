import 'package:cpd/screens/quiz_screen.dart';
import 'package:cpd/styling/size_params.dart';
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
      if(name1 == "Module 1"){
        FirebaseFunctions().Module1.set({
          "progress": 0,
          "completed": false,
          "correct": 0,
        });
      }
      if(name1 == "Module 2"){
        FirebaseFunctions().Module2.set({
          "progress": 0,
          "completed": false,
          "correct": 0,
        });
      }
      if(name1 == "Module 3"){
        FirebaseFunctions().Module3.set({
          "progress": 0,
          "completed": false,
          "correct": 0,
        });
      }
      if(name1 == "Module 4"){
        FirebaseFunctions().Module4.set({
          "progress": 0,
          "completed": false,
          "correct": 0,
        });
      }

    }

    return QuizScreen.of(context)!.finalPoints;
    return 999;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: SizeParams().quarterHeight(context) * 3,
        width: SizeParams().quarterWidth(context) * 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //TODO: Replace this with the app icon
            Icon(
              Icons.route,
              size: SizeParams().welcomeLogoWidth(context),
              color: Theme.of(context).primaryColor,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Text(
                "Congratulations!",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Text(
              "You completed ${_getModuleName(context)} and received ${_getPoints(context)} points!",
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
