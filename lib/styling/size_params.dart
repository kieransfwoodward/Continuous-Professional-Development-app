import 'package:flutter/material.dart';

class SizeParams {
  double fullWidth(BuildContext context) => MediaQuery.of(context).size.width;

  double widthWithPadding(BuildContext context) =>
      MediaQuery.of(context).size.width - 32;

  double itemImageWidth(BuildContext context) =>
      (MediaQuery.of(context).size.width - 48) / 3;

  double welcomeLogoWidth(BuildContext context) =>
      MediaQuery.of(context).size.width / 2;

  double quarterWidth(BuildContext context) =>
      MediaQuery.of(context).size.width / 4;

  double twoThirdsWidth(BuildContext context) =>
      (MediaQuery.of(context).size.width / 4) * 3;

  double twoThirdsWidthWithExtraSpace(BuildContext context) =>
      ((MediaQuery.of(context).size.width / 4) * 3) - 38;

  double next(BuildContext context) =>
      ((MediaQuery.of(context).size.width / 4) * 2.5) - 38;

  double quarterHeight(BuildContext context) =>
      MediaQuery.of(context).size.height / 4;

  double leaderboardImageSize(BuildContext context) =>
      MediaQuery.of(context).size.width / 8;
}
