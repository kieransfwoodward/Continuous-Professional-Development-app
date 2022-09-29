import 'package:flutter/material.dart';

class CustomBorder {
  BorderRadius borderRadius = BorderRadius.circular(16.0);
  BorderRadius largeBorderRadius = BorderRadius.circular(32.0);
  BorderRadius topOnlyBorder = const BorderRadius.vertical(
    top: Radius.circular(16.0),
  );

  // Outside border only
  BoxDecoration defaultBorder(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).canvasColor,
      shape: BoxShape.rectangle,
      borderRadius: borderRadius,
      border: Border.all(
        color: Theme.of(context).primaryColor,
        width: 1,
      ),
    );
  }

  // No border but rounded container
  BoxDecoration noBorderRounded() {
    return BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: borderRadius,
    );
  }

  // Rounded border with a the same theme colour
  BoxDecoration roundedFilled(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).primaryColor,
      shape: BoxShape.rectangle,
      borderRadius: borderRadius,
    );
  }

  //Border for the app bar progress widgets
  BoxDecoration progressWidgetBorder(BuildContext context) {
    return BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: borderRadius,
      border: Border.all(
        color: Theme.of(context).canvasColor,
        width: 2,
      ),
    );
  }

  // Border for other options on menu
  BoxDecoration optionsIconDecoration(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).primaryColor,
      border: Border.all(
        color: Theme.of(context).canvasColor,
        width: 2,
      ),
      borderRadius: CustomBorder().largeBorderRadius,
    );
  }

  // Border and filled colour for empty images
  BoxDecoration imageDecoration(BuildContext context) {
    return BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: borderRadius,
      //color: Theme.of(context).secondaryHeaderColor,
      // border: Border.all(
      //   color: Theme.of(context).primaryColor,
      //   width: 1,
      // ),
    );
  }

  // Filled colour for user specific leaderboard items
  BoxDecoration leaderboardDecoration(BuildContext context) {
    return BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: borderRadius,
      color: Theme.of(context).secondaryHeaderColor,
    );
  }
}
