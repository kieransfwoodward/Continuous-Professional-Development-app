import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cpd/functions/questions/question_functions.dart';
import 'package:cpd/widgets/app_bars/quiz_question_app_bar.dart';
import 'package:cpd/widgets/buttons/quiz/bottom_nav_buttons.dart';
import 'package:cpd/widgets/content_area.dart';
import 'package:cpd/widgets/quiz/finished_quiz_page.dart';
import 'package:flutter/material.dart';

// Quiz page

class QuizScreen extends StatefulWidget {
  const QuizScreen({
    Key? key,
    required this.documentId,
    required this.reference,
    required this.data,
  }) : super(key: key);

  final String documentId;
  final DocumentReference reference;
  final Map<String, dynamic> data;

  @override
  State<QuizScreen> createState() => _QuizScreenState();

  static _QuizScreenState? of(BuildContext context) =>
      context.findAncestorStateOfType<_QuizScreenState>();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentPageIndex = 0;
  List<Widget> _pages = [];
  int _totalPoints = 0;
  bool _isLoading = true;

  // Used to update the question as a callback
  set currentPage(int currentPageIndex) => setState(
        () => _currentPageIndex = currentPageIndex,
      );

  // Used to update the points as a callback
  set points(int totalPoints) => setState(
        () => _totalPoints = totalPoints,
      );

  // Gets the points
  int get finalPoints => _totalPoints;

  // Gets the module name
  String get moduleName => widget.data["name"];

  // Gets the quiz questions
  Future<void> _prepareQuiz() async {
    await FirebaseFirestore.instance
        .collection("modules")
        .doc(widget.documentId)
        .collection("questions")
        .get()
        .then((snapshot) {
      for (DocumentSnapshot doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        // Gets the appropriate question layout based on the type
        _pages.add(
          QuestionFunctions().getQuestionType(
            type: data["type"],
            moduleId: widget.documentId,
            questionNumber: doc.id,
            data: data,
          ),
        );
      }
    }).then(
      (value) => setState(() {
        // TODO: Needs a pass check - restart the quiz if they have failed and show this on the last screen
        // Adds the finished page
        _pages.add(const FinishedQuizPage());
        _isLoading = false;
      }),
    );
  }

  @override
  void initState() {
    _prepareQuiz();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _isLoading
                    ? const LinearProgressIndicator()
                    : QuizQuestionAppBar(
                        currentQuestionIndex: _currentPageIndex,
                        totalQuestions: _pages.length - 1,
                      ),
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ContentArea(
                        child: _isLoading
                            ? const CircularProgressIndicator()
                            : IndexedStack(
                                index: _currentPageIndex,
                                children: _pages,
                              ),
                      ),
                      Positioned(
                        bottom: 16,
                        left: 32,
                        right: 32,
                        child: Center(
                          child: BottomNavButtons(
                            // Current page is first page if current page index is 0
                            isFirstPage: _currentPageIndex == 0,
                            // Current page is last page if current page number is the same as the number of pages
                            isLastPage:
                                (_currentPageIndex + 1) == _pages.length,
                            currentPageIndex: _currentPageIndex,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
