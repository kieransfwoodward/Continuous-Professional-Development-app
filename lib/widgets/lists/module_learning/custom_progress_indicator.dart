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


    AlertDialog alert1 = const AlertDialog(
      title: Text("Completion"),
      content: Text("To complete a module, finsih it while scoring at least 80% to earn a completion tick."
          "\n\nIf you would like to comeplete the module, feel free, but if you don't reach the 80% mark "
          "again, you will lose your tick."),
      actions: [
        //okButton,
      ],
    );

      if (isComplete) {
        // return SizedBox(
        //   width: 20,
        //   height: 20,
        //
        //   child: CircularProgressIndicator(
        //     strokeWidth: 2,
        //     value: 0.6,
        //     color: Colors.red,
        //     backgroundColor: Theme
        //         .of(context)
        //         .secondaryHeaderColor,
        //   ),
        // );
        return SizedBox(
          width: 20,
          height: 20,


          child:
          // GestureDetector(
          //   child:
            Icon(Icons.check_box_sharp,
              color: Colors.green,),
          //   onTap: () {
          //     showDialog(
          //       context: context,
          //       builder: (BuildContext context) {
          //         return alert1;
          //       },
          //     );
          //   },
          // ),
          // strokeWidth: 2,
          // value: 0.6,
          // color: Colors.blue,


        );

      }
      else {
        return SizedBox(
          width: 20,
          height: 20,


          child:
          // GestureDetector(
          //   child:
            Icon(Icons.check_box_outline_blank_outlined,
              color: const Color(0xffd47828),),
          //   onTap: () {
          //     showDialog(
          //       context: context,
          //       builder: (BuildContext context) {
          //         return alert1;
          //       },
          //     );
          //   },
          // ),
          // strokeWidth: 2,
          // value: 0.6,
          // color: Colors.blue,


        );
      }

  }

}
