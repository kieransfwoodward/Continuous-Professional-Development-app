import 'package:cpd/widgets/quiz/drag_and_drop.dart';
import 'package:cpd/widgets/quiz/learn_text_input.dart';
import 'package:cpd/widgets/quiz/single_image_multiple_choice_question.dart';
import 'package:flutter/material.dart';

import '../../widgets/quiz/ImagePainterExample.dart';
import '../../widgets/quiz/draggable_list.dart';
import '../../widgets/quiz/draggable_list_M2_CollabSkills.dart';
import '../../widgets/quiz/draggable_list_M2_DesignProcess.dart';
import '../../widgets/quiz/reorder_m1_pyramid.dart';
import '../../widgets/quiz/reorder_m2_collaborative.dart';
import '../../widgets/quiz/reorder_m2_designProcess.dart';
import '../../widgets/quiz/learn_image.dart';
import '../../widgets/quiz/learn_img2.dart';
import '../../widgets/quiz/learn_img3.dart';
import '../../widgets/quiz/learn_text.dart';
import '../../widgets/quiz/learn_link.dart';
import '../../widgets/quiz/learn_link_mod.dart';
import '../../widgets/quiz/learn_video.dart';
import '../../widgets/quiz/single_multiple_choice_question.dart';
import '../../widgets/quiz/interact_image.dart';
import '../../widgets/quiz/interact_m3image_collab.dart';
import '../../widgets/quiz/interact_m3image_reliable.dart';
import '../../widgets/quiz/interact_m4image_nono.dart';
import '../../widgets/quiz/interact_m4image_calltoaction.dart';
import '../../widgets/quiz/image_slideshow.dart';
import '../../widgets/quiz/check_understanding.dart';
import '../../widgets/quiz/single_multiple_choice_question_blank.dart';
import '../../widgets/quiz/learn_expandM2.dart';
import '../../widgets/quiz/learn_expandM3_Const.dart';
import '../../widgets/quiz/learn_expandM3_DragDropAns.dart';
import '../../widgets/quiz/learn_expandM1_peakRapport.dart';


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
    }if (type.contains("single_multiple_blank")) {
      return SingleMultipleChoiceQuestionBlank(
        moduleId: moduleId,
        questionNumber: questionNumber,
        data: data,
      );
    }
    if (type == "learn_text") {
      return learn_text(
        moduleId: moduleId,
        questionNumber: questionNumber,
        data: data,
      );
    }
    if (type == "learn_link") {
      return learn_link(
        moduleId: moduleId,
        questionNumber: questionNumber,
        data: data,
      );
    }if (type == "learn_mod") {
      return learn_link_mod(
        moduleId: moduleId,
        questionNumber: questionNumber,
        data: data,
      );
    }
    if (type == "learn_image") {
      return LearnImage(
        moduleId: moduleId,
        questionNumber: questionNumber,
        data: data,
      );
    }
    if (type == "learn_2img") {
      return Learn2Img(
        moduleId: moduleId,
        questionNumber: questionNumber,
        data: data,
      );
    }
    if (type == "learn_3img") {
      return Learn3Img(
        moduleId: moduleId,
        questionNumber: questionNumber,
        data: data,
      );
    }
    if (type == "check_understanding") {
      return CheckUnderstanding(
        moduleId: moduleId,
        questionNumber: questionNumber,
        data: data,
      );
    }
    if (type.contains("learn_video")) {
      return learn_video(
        moduleId: moduleId,
        questionNumber: questionNumber,
        data: data,
      );
    }
    if (type == "learn_text_input") {
      return learn_text_input(
        moduleId: moduleId,
        questionNumber: questionNumber,
        data: data,
      );
    }
    if (type == "drag_drop_module_one") {
      return ExpansionTileExample(
        moduleId: moduleId,
        questionNumber: questionNumber,
        data: data,
      );
    }
    if (type == "drag_drop_module_two_collabskills") {
      return draggable_list_M2_CollabSkills(
        moduleId: moduleId,
        questionNumber: questionNumber,
        data: data,
      );
    }
    if (type == "draggable_list_M2_DesignProcess") {
      return draggable_list_M2_DesignProcess(
        moduleId: moduleId,
        questionNumber: questionNumber,
        data: data,
      );
    }
    if (type == "reorder_m1_pyramid") {
      return reorder_m1_pyramid(
        moduleId: moduleId,
        questionNumber: questionNumber,
        data: data,
      );
    }
    if (type == "reorder_m2_collaborative") {
      return reorder_m2_collaborative(
        moduleId: moduleId,
        questionNumber: questionNumber,
        data: data,
      );
    }
    if (type == "reorder_m2_designProcess") {
      return reorder_m2_designProcess(
        moduleId: moduleId,
        questionNumber: questionNumber,
        data: data,
      );
    }
    if (type == "drag_drop_module_three") {
      return drag_and_drop(
      );
    }
    if (type == "learn_M2Expand") {
      return learn_M2Expand(
        moduleId: moduleId,
        questionNumber: questionNumber,
        data: data,
      );
    }
    if (type == "learn_M3Expand_Const") {
      return learn_M3Expand_Const(
        moduleId: moduleId,
        questionNumber: questionNumber,
        data: data,
      );
    }
    if (type == "learn_expandM3_DragDropAns") {
      return learn_expandM3_DragDropAns(
        moduleId: moduleId,
        questionNumber: questionNumber,
        data: data,
      );
    }
    if (type == "learn_expandM1_peakRapport") {
      return learn_expandM1_peakRapport(
        moduleId: moduleId,
        questionNumber: questionNumber,
        data: data,
      );
    }
    if (type == "painter") {
      return ImagePainterExample(
      );
    }
    if (type == "interact_image_m4") {
      return interact_image(
        moduleId: moduleId,
        questionNumber: questionNumber,
        data: data,
      );
    }
    if (type == "interact_m3image_collab") {
      return interact_m3image_collab(
        moduleId: moduleId,
        questionNumber: questionNumber,
        data: data,
      );
    }
    if (type == "interact_m3image_reliable") {
      return interact_m3image_reliable(
        moduleId: moduleId,
        questionNumber: questionNumber,
        data: data,
      );
    }
    if (type == "interact_m4image_nono") {
      return interact_m4image_nono(
        moduleId: moduleId,
        questionNumber: questionNumber,
        data: data,
      );
    }
    if (type == "interact_m4image_calltoaction") {
      return interact_m4image_calltoaction(
        moduleId: moduleId,
        questionNumber: questionNumber,
        data: data,
      );
    }
    if (type == "image_slideshow2") {
      return Carousel(
        moduleId: moduleId,
        questionNumber: questionNumber,
        data: data,
      );
    }
    return Container();
  }
}
