import 'dart:ffi';

import 'package:flutter/material.dart';

import '../../../functions/firebase_functions.dart';

// TODO: This needs finishing - future builder
// TODO: Replace green circle with tick

class CustomProgressIndicator extends StatelessWidget {
  CustomProgressIndicator({Key? key, required this.module, required this.isComplete}) : super(key: key);
  String module = "";
  bool isComplete = false;

  checkProgress() {
    FirebaseFunctions().Module3.get().then((doc) {
      isComplete = (doc.data() as Map<String, dynamic>)["completed"] ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {



      if (!isComplete) {
        return SizedBox(
          width: 20,
          height: 20,

          child: CircularProgressIndicator(
            strokeWidth: 2,
            value: 0.6,
            color: Colors.red,
            backgroundColor: Theme
                .of(context)
                .secondaryHeaderColor,
          ),
        );
      }
      else {
        return SizedBox(
          width: 20,
          height: 20,


            child: Icon(Icons.check,
            color: Colors.green,),
            // strokeWidth: 2,
            // value: 0.6,
            // color: Colors.blue,


        );
      }

  }

}
