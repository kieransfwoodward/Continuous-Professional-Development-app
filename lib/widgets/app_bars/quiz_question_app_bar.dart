import 'package:cpd/styling/custom_border.dart';
import 'package:cpd/widgets/app_bars/close_to_home.dart';
import 'package:flutter/material.dart';

// App bar for the Quiz page

class QuizQuestionAppBar extends StatelessWidget {
  const QuizQuestionAppBar({
    Key? key,
    required this.currentQuestionIndex,
    required this.totalQuestions,
  }) : super(key: key);
  final int totalQuestions, currentQuestionIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16.0,
        left: 16.0,
        right: 16,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const CloseToHome(),
          // Only show progress bar while the quiz is in progress
          totalQuestions != currentQuestionIndex
              ? Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipRRect(
                      borderRadius: CustomBorder().borderRadius,
                      child: LinearProgressIndicator(
                        // Checks and calculates the current question number - starting index is 0
                        value: totalQuestions != 0 && currentQuestionIndex != 0
                            ? ((100 / totalQuestions) * currentQuestionIndex) /
                                100
                            : 0,
                        minHeight: 16,
                        color: Theme.of(context).canvasColor,
                      ),
                    ),
                  ),
                )
              : Container(),

          // Only show question number while the quiz is in progress
          totalQuestions != currentQuestionIndex
              ? Text(
                  // Starting index of 0 means question 1, add 1 to show this
                  "Q${currentQuestionIndex + 1}",
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        color: Theme.of(context).canvasColor,
                      ),
                )
              : Container(),
        ],
      ),
    );
  }
}
