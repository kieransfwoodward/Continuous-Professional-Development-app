import 'package:cpd/screens/quiz_screen.dart';
import 'package:cpd/styling/size_params.dart';
import 'package:cpd/widgets/buttons/flat_colour_button.dart';
import 'package:cpd/widgets/buttons/text/contrast_button_text.dart';
import 'package:flutter/material.dart';

// Bottom navigation buttons

// Callback to updatePageIndex
typedef Callback = void Function(int pageIndex);

class BottomNavButtons extends StatefulWidget {
  const BottomNavButtons({
    Key? key,
    required this.isFirstPage,
    required this.isLastPage,
    required this.currentPageIndex,
  }) : super(key: key);
  final bool isFirstPage, isLastPage;
  final int currentPageIndex;

  @override
  State<BottomNavButtons> createState() => _BottomNavButtonsState();
}

class _BottomNavButtonsState extends State<BottomNavButtons> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          FlatColourButton(
            onTap: () => widget.isFirstPage
                ? Navigator.pop(context)
                : setState(() {
                    // Go back to previous question
                    if (QuizScreen.of(context) != null) {
                      // Update the current page index
                      QuizScreen.of(context)!.currentPage =
                          widget.currentPageIndex - 1;
                    }
                  }),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: Theme.of(context).canvasColor,
            ),
            width: null,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: FlatColourButton(
              onTap: () => widget.isLastPage
                  ? Navigator.of(context).popUntil((route) => route.isFirst)
                  : setState(() {
                      // Go to next question
                      if (QuizScreen.of(context) != null) {
                        // Update the current page index
                        QuizScreen.of(context)!.currentPage =
                            widget.currentPageIndex + 1;
                      }
                    }),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: ContrastButtonText(
                  text: widget.isLastPage ? "Finish" : "Next",
                ),
              ),
              width: SizeParams().twoThirdsWidthWithExtraSpace(context),
            ),
          ),
        ],
      ),
    );
  }
}
