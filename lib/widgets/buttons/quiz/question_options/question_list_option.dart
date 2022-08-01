import 'package:cpd/styling/custom_border.dart';
import 'package:cpd/widgets/buttons/text/left_align_button_text.dart';
import 'package:flutter/material.dart';

// Question list option
//https://stackoverflow.com/questions/50060276/flutter-custom-radio-button

class QuestionListOption extends StatelessWidget {
  const QuestionListOption({
    Key? key,
    required this.value,
    required this.onTap,
    required this.text,
    required this.groupValue,
    required this.correctAnswer,
    required this.optionTapped,
  }) : super(key: key);

  final int value;
  final String text;
  final Function() onTap;
  final int groupValue, correctAnswer;
  final bool optionTapped;

  Color _getColor(BuildContext context) {
    if (optionTapped) {
      if (value == groupValue && groupValue == correctAnswer) {
        return Colors.green;
      } else if (value == groupValue && groupValue != correctAnswer) {
        return Theme.of(context).errorColor;
      }
      else if (value == correctAnswer) {
        return Colors.green;
      }
    }
    return Theme.of(context).canvasColor;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: CustomBorder().borderRadius,
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: _getColor(context), width: 5),
          borderRadius: CustomBorder().borderRadius,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            child: LeftAlignButtonText(
              text: text,
            ),
          ),
        ),
      ),
      onTap: onTap,
    );


  }
}
