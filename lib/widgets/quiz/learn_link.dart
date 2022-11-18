import 'package:cpd/functions/firebase_functions.dart';
import 'package:cpd/screens/quiz_screen.dart';
import 'package:cpd/widgets/image/module_banner_image.dart';
import 'package:cpd/widgets/lists/list_view_separator.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// Multiple choice question sheet, with the focus being the image

//TODO: Save completion of question

class learn_link extends StatefulWidget {
  const learn_link({
    Key? key,
    required this.moduleId,
    required this.questionNumber,
    required this.data,
  }) : super(key: key);

  final String moduleId;
  final String questionNumber;
  final Map<String, dynamic> data;

  @override
  State<learn_link> createState() => _learn_textState();
}

class _learn_textState extends State<learn_link> {
  int _groupOptionVal = 1;
  bool _optionSelected = false;
  bool ticked = false;

  @override
  initState() {
    // _updatePoints();

    super.initState();
  }

  Future<void> _updatePoints() async {
    if (QuizScreen.of(context) != null) {
      FirebaseFunctions().user.get().then((doc) {
        if (doc.data() != null) {
          int points =
              (doc.data() as Map<String, dynamic>)["current_points"] ?? 0;
          FirebaseFunctions().user.update({
            "current_points": points + widget.data["points"] as int,
          });
        }
      });

      // QuizScreen.of(context)!.points =
      //     QuizScreen.of(context)!.finalPoints + (widget.data["points"] as int);
    }

    String name1 = QuizScreen.of(context)!.moduleName;
    int page = QuizScreen.of(context)!.currentPageIndex + 1;
    if (name1 == "Module 1") {
      FirebaseFunctions().Module1.update({
        "progress": page,
      });
    }
    if (name1 == "Module 2") {
      FirebaseFunctions().Module2.update({
        "progress": page,
      });
    }
    if (name1 == "Module 3") {
      FirebaseFunctions().Module3.update({
        "progress": page,
      });
    }
    if (name1 == "Module 4") {
      FirebaseFunctions().Module4.update({
        "progress": page,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 16.0,
              bottom: 4.0,
            ),
            child: Text(
              widget.data["question_title"],
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          const ListViewSeparator(),
          ModuleBannerImage(
            imagePath: widget.data["image_url"],
            imageType: ImageType.banner4,
          ),
          Center(
            child: Text(
              widget.data["question_subtitle"],
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Center(
              child: InkWell(
                  child: const Text(
                    'Touch here to see more',
                    style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: const Color(0xffd47828),
                    ),
                  ),
                  onTap: () => launch(widget.data["link"])),
            ),
          ),
          // Checkbox(
          //   checkColor: Colors.white,
          //   fillColor: MaterialStateProperty.resolveWith(Colors.blue),
          //   value: false,
          //   onChanged: (bool? value) {
          //     setState(() {
          //       _updatePoints()
          //     });
          //   },
          // ),
          const ListViewSeparator(),
          CheckboxListTile(
            title: const Text('Save progress'),
            value: ticked,
            onChanged: (bool? value) {
              setState(() {
                ticked = true;
                _updatePoints();
              });
            },
          ),

          Padding(
            padding: EdgeInsets.only(bottom: 60.0),
          ),
        ],
      ),
    );
  }
}
