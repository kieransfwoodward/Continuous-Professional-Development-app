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
        FirebaseFunctions().Module1.update({
          "completed": false,

        });
      }
      if(name1 == "Module 2"){
        FirebaseFunctions().Module2.update({
          "completed": false,
        });
      }
      if(name1 == "Module 3"){
        FirebaseFunctions().Module3.update({
          "completed": false,
        });
      }
      if(name1 == "Module 4"){
        FirebaseFunctions().Module4.update({
          "completed": false,
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
