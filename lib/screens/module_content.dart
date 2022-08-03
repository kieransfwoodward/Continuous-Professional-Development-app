import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cpd/screens/quiz_screen.dart';
import 'package:cpd/styling/custom_border.dart';
import 'package:cpd/widgets/app_bars/module_content_app_bar.dart';
import 'package:cpd/widgets/buttons/text/button_text.dart';
import 'package:cpd/widgets/content_area.dart';
import 'package:cpd/widgets/image/module_banner_image.dart';
import 'package:cpd/widgets/lists/list_view_separator.dart';
import 'package:flutter/material.dart';

// Shows module overview

class ModuleContent extends StatelessWidget {
  const ModuleContent({
    Key? key,
    required this.documentId,
    required this.reference,
    required this.data,
    required this.duration,
    required this.points,
  }) : super(key: key);

  final String documentId;
  final DocumentReference reference;
  final Map<String, dynamic> data;
  final int duration, points;

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
                ModuleContentAppBar(
                  duration: duration,
                  points: points,
                ),
                SingleChildScrollView(
                  child: ContentArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ModuleBannerImage(
                          imagePath: data["image_url"],
                          imageType: ImageType.banner,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 16.0,
                            bottom: 4.0,
                          ),
                          child: Text(
                            data["name"],
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                        Text(
                          data["subtitle"],
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        const ListViewSeparator(),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            "Your CPD is:",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                        Column(
                          children: (data["content_covered"] as List)
                              .map(
                                (content) => Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6.0),
                                      child: Icon(
                                        Icons.circle,
                                        size: 8,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 8.0,
                                          bottom: 8.0,
                                        ),
                                        child: Text(
                                          content,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: InkWell(
                            borderRadius: CustomBorder().borderRadius,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QuizScreen(
                                  documentId: documentId,
                                  reference: reference,
                                  data: data,
                                ),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const ButtonText(text: "PLAY"),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: Icon(
                                    Icons.play_circle_outline,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),

                              ],

                            ),
                          ),
                        ),
                      ],
                    ),
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
