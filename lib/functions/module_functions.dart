import 'package:cloud_firestore/cloud_firestore.dart';

class ModuleFunctions {
  final double _timePerQuiz = 1.5;

  // Calculates the total time to complete a quiz
  int calculateQuizTime(int? numOfQuestions) {
    return (numOfQuestions! * _timePerQuiz).round();
  }

  // Gets the number of items in a Collection
  Future<int> calculateQuestions({
    required CollectionReference ref,
  }) async {
    QuerySnapshot snapshot = await ref.get();
    return snapshot.docs.length;
  }

  // Iterates through the provides Collection reference and adds up the total points for each quiz
  Future<int> calculateTotalPoints({
    required CollectionReference ref,
  }) async {
    int points = 0;
    await ref.get().then(
      (snapshot) {
        for (QueryDocumentSnapshot doc in snapshot.docs) {
          points += int.parse(
            (doc.data() as Map<String, dynamic>)["points"].toString(),
          );
        }
      },
    );

    return points;
  }
}
