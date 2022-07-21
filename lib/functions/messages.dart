import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Functions {
  //Shows a snackbar
  Future<void> showSnackBar({
    required BuildContext context,
    required bool isError,
    required String message,
  }) async {
    // If the snackbar is an error message, only the error needs to be passed in
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${isError ? "An error occurred:" : ""} $message"),
        action: SnackBarAction(
          label: "Close",
          onPressed: () {},
        ),
      ),
    );
  }

  //Show a toast (a small text icon in the bottom center of the page)
  Future<void> showToast({
    required BuildContext context,
    required String message,
  }) async {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      textColor: Theme.of(context).primaryColor,
    );
  }
}
