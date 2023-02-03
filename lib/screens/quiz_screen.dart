import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cpd/functions/questions/question_functions.dart';
import 'package:cpd/widgets/app_bars/quiz_question_app_bar.dart';
import 'package:cpd/widgets/buttons/quiz/bottom_nav_buttons.dart';
import 'package:cpd/widgets/content_area.dart';
import 'package:cpd/widgets/quiz/finished_quiz_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import '../functions/firebase_functions.dart';
import 'home_screen.dart';

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
  void points() {
    // Updates the Finished Quiz Page
    //  _pages.removeAt(_pages.length - 1);

    // Updates the total score
    //_totalPoints = totalPoints + _totalPoints;


      FirebaseFirestore.instance
          .collection("modules")
          .doc(moduleName).collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid).get().then((doc) {
        if (doc.data() != null) {
          _totalPoints = (doc.data() as Map<String, dynamic>)["correct"] ?? 99;
        }
      });


    //  _pages.add(const FinishedQuizPage());

    //return _totalPoints;
  }

  // Gets the points
  int get currentPageIndex => _currentPageIndex;

  int get finalPoints => _totalPoints;

  // Gets the module name
  String get moduleName => widget.data["name"];
  // Gets the module title
  String get moduleTitle => widget.data["title"];

  // Gets the quiz questions
  Future<void> _prepareQuiz() async {

      FirebaseFirestore.instance
          .collection("modules")
          .doc(moduleName).collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid).get().then((doc) {
        _currentPageIndex =
            (doc.data() as Map<String, dynamic>)["progress"] ?? 0;
      });


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

  reset() {
    bool complete = false;
    double complete_score = 0;
    String timeComplete = "";

    String name1 = moduleName;



      int correct = 0;
      int total = 0;
      double totalScore = 0;
      FirebaseFirestore.instance
          .collection("modules")
          .doc(name1).collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid).get().then((doc) {
        correct = (doc.data() as Map<String, dynamic>)["correct"] ?? 0;
        FirebaseFirestore.instance
            .collection("modules")
            .doc(name1)
            .get()
            .then((doc) {
          total = (doc.data() as Map<String, dynamic>)["total"] ?? 0;
          totalScore = ((correct/total) *100) as double;
          if (totalScore >= 80) {
            complete = true;
            complete_score = totalScore;
            //timeComplete
          }
          if (totalScore >= 80){
            FirebaseFirestore.instance
                .collection("modules")
                .doc(name1).collection("users")
                .doc(FirebaseAuth.instance.currentUser!.uid).set({
              "progress": 0,
              "completed": complete,
              "correct": 0,
              "totalScore": totalScore,
              "time_completed": DateTime.now(),
              "score_complete": complete_score,
            },
              SetOptions(merge:true),
            );
          }
          else{
            FirebaseFirestore.instance
                .collection("modules")
                .doc(name1).collection("users")
                .doc(FirebaseAuth.instance.currentUser!.uid).set({
              "progress": 0,
              "completed": complete,
              "correct": 0,
              "totalScore": totalScore,
              // "time_completed": DateTime.now(),
              // "score_complete": totalScore,
            },
              SetOptions(merge:true),
            );
          }
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return HomeScreen();
            }),
          );
        });
      });




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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ContentArea(
                          child: _isLoading
                              ? const CircularProgressIndicator()
                              : IndexedStack(
                                  index: _currentPageIndex,
                                  children: _pages,
                                ),
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
