import 'package:cpd/functions/firebase_functions.dart';
import 'package:cpd/styling/custom_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProgressItem extends StatelessWidget {
  const ProgressItem({
    Key? key,
    required this.icon,
    required this.collectionRefName,
    required this.docRefName,
    required this.field,
    required this.textToInclude,
    required this.returnValIfNull,
  }) : super(key: key);

  final IconData icon;
  final String collectionRefName, docRefName, field;
  final String? textToInclude;
  final int? returnValIfNull;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: CustomBorder().progressWidgetBorder(context),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: const Color(0xffd47828),
              size: 18,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                right: 2.0,
              ),
              child: FirebaseFunctions().getField(
                collectionRef:
                    FirebaseFunctions().userCol,
                docRef: FirebaseAuth.instance.currentUser!.uid,
                field: field,
                prefixText: textToInclude,
                returnValIfNull: returnValIfNull,
                style: Theme.of(context).textTheme.subtitle2?.copyWith(
                  color: const Color(0xffd47828),
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
