import 'package:cpd/widgets/quiz/single_image_multiple_choice_question.dart';
import 'package:flutter/material.dart';

import '../../widgets/quiz/single_multiple_choice_question.dart';

// Deals with question specific functions
class QuestionFunctions {
  // Returns a widget based on the question type from Firebase
  Widget getQuestionType({
    required String type,
    required Map<String, dynamic> data,
    required String moduleId,
    required String questionNumber,
  }) {
    if (type.contains("single_image_multiple_choice")) {
      return SingleImageMultipleChoiceQuestion(
        moduleId: moduleId,
        questionNumber: questionNumber,
        data: data,
      );
    }
    if (type.contains("single_multiple_choice")) {
      return SingleMultipleChoiceQuestion(
        moduleId: moduleId,
        questionNumber: questionNumber,
        data: data,
      );
    }
    return Container();
  }
}
