import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseFunctions {
  // Instance of the current users Firebase directory
  DocumentReference user = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid);

  DocumentReference Module3 = FirebaseFirestore.instance
      .collection("modules")
  .doc("Module3").collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid);

  DocumentReference Module1 = FirebaseFirestore.instance
      .collection("modules")
      .doc("Module1").collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid);

  DocumentReference Module2 = FirebaseFirestore.instance
      .collection("modules")
      .doc("Module2").collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid);

  DocumentReference Module4 = FirebaseFirestore.instance
      .collection("modules")
      .doc("Module4").collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid);


  // Gets a firebase field once based on a passed in Document Reference and Field
  FutureBuilder getFieldByDocId({
    required DocumentReference ref,
    required String field,
    required String? prefixText,
    required String? returnValIfNull,
    required TextStyle? style,
  }) =>
      FutureBuilder<DocumentSnapshot<Object?>>(
        future: ref.get(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot<Object?>> snapshot) {
          // Shown if there is an error
          if (snapshot.hasError) {
            return Text(
              "ERROR",
              style: style,
            );
          }

          // Shown if there is no data, can be set beforehand or a default value used
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Text(
              "$prefixText${returnValIfNull ?? "No data present"}",
              style: style,
            );
          }

          // If the connection is finished, show the text, including any prefix text
          if (snapshot.connectionState == ConnectionState.done) {
            Map data = snapshot.data!.data() as Map<String, dynamic>;

            return Text(
              "$prefixText${data[field] ?? ""}",
              style: style,
            );
          }

          // Show a loading indicator
          return SizedBox(
            height: 12.0,
            width: 12.0,
            child: CircularProgressIndicator(
              color: Theme.of(context).canvasColor,
              strokeWidth: 2,
            ),
          );
        },
      );

  // Gets a firebase field in real-time based on a passed in Collection Reference and Field
  StreamBuilder getFieldLiveByDocId({
    required CollectionReference collectionRef,
    required String docRef,
    required String field,
    required String? prefixText,
    required int? returnValIfNull,
    required TextStyle? style,
  }) =>
      StreamBuilder<QuerySnapshot<Object?>>(
        stream: collectionRef.snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
          // Shown if there is an error
          if (snapshot.hasError) {
            return Text(
              "ERROR",
              style: style,
            );
          }

          // Shown if there is no data, can be set beforehand or a default value used
          if (!snapshot.hasData) {
            return Text(
              returnValIfNull != null ? returnValIfNull.toString() : "?",
              style: style,
            );
          }

          // If the connection is finished, show the text, including any prefix text
          if (snapshot.connectionState != ConnectionState.waiting) {
            // Get the first document where the ID of that document matches the passed in document
            List<QueryDocumentSnapshot<Object?>> docs = snapshot.data!.docs
                .where((doc) => doc.id.contains(docRef))
                .toList();

            String text =
                returnValIfNull != null ? returnValIfNull.toString() : "?";
            if (docs.isNotEmpty) {
              Map<String, dynamic> data =
                  docs.first.data() as Map<String, dynamic>;
              if (data.isNotEmpty) {
                text = data[field].toString();
              }
            }

            return Text(
              "${prefixText ?? ""}$text",
              style: style,
            );
          }

          // Show a loading indicator
          return SizedBox(
            height: 12.0,
            width: 12.0,
            child: CircularProgressIndicator(
              color: Theme.of(context).canvasColor,
              strokeWidth: 2,
            ),
          );
        },
      );
}
