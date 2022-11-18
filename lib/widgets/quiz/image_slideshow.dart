import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../functions/firebase_functions.dart';
import 'package:cpd/screens/quiz_screen.dart';
import 'package:cpd/widgets/lists/list_view_separator.dart';
import 'package:cpd/functions/firebase_functions.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Material App',
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Image carousel'),
//         ),
//         body: Carousel(),
//       ),
//     );
//   }
// }


class Carousel extends StatefulWidget {
  const Carousel({Key? key,
    required this.moduleId,
    required this.questionNumber,
    required this.data,
  }) : super(key: key);

  final String moduleId;
  final String questionNumber;
  final Map<String, dynamic> data;

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {

  bool ticked = false;

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
    int page = QuizScreen.of(context)!.currentPageIndex +1;
    if(name1 == "Module 1"){
      FirebaseFunctions().Module1.update({
        "progress": page,
      });
    }
    if(name1 == "Module 2"){
      FirebaseFunctions().Module2.update({
        "progress": page,
      });
    }
    if(name1 == "Module 3"){
      FirebaseFunctions().Module3.update({
        "progress": page,
      });
    }
    if(name1 == "Module 4"){
      FirebaseFunctions().Module4.update({
        "progress": page,
      });
    }

  }

  late PageController _pageController;

  List<String> images = [
    "https://firebasestorage.googleapis.com/v0/b/citb-cpd.appspot.com/o/Module_2_TreeHouse_1ss.png?alt=media&token=93d34d21-6243-42e1-a033-6893f3bc3a6c",
    "https://firebasestorage.googleapis.com/v0/b/citb-cpd.appspot.com/o/Module_2_TreeHouse_2ss.png?alt=media&token=03d873f5-858b-4ad2-809d-4dbcbd2b959f",
    "https://firebasestorage.googleapis.com/v0/b/citb-cpd.appspot.com/o/Module_2_TreeHouse_3ss.png?alt=media&token=31d5dd0c-82b1-47d9-947e-740676c6a0fa",
    "https://firebasestorage.googleapis.com/v0/b/citb-cpd.appspot.com/o/Module_2_TreeHouse_4ss.png?alt=media&token=173b3980-1268-47a3-a11a-577833703814",
    "https://firebasestorage.googleapis.com/v0/b/citb-cpd.appspot.com/o/Module_2_TreeHouse_5ss.png?alt=media&token=4ef63fd9-8101-4757-b055-ff1b905bb892",
    "https://firebasestorage.googleapis.com/v0/b/citb-cpd.appspot.com/o/Module_2_TreeHouse_6ss.png?alt=media&token=da17c1d9-b73e-4148-9e1c-163cb1fc8cc7",
    "https://firebasestorage.googleapis.com/v0/b/citb-cpd.appspot.com/o/Module_2_TreeHouse_7ss.png?alt=media&token=6a318fcc-a444-46b2-8d2f-951a7a35a4ac"

  ];

  int activePage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8, initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
        Text(
          widget.data["question_subtitle"],
          style: Theme.of(context).textTheme.subtitle1,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 400,
          child: PageView.builder(
              itemCount: images.length,
              pageSnapping: true,
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  activePage = page;
                });
              },
              itemBuilder: (context, pagePosition) {
                bool active = pagePosition == activePage;
                return slider(images,pagePosition,active);
              }),
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: indicators(images.length,activePage)
        ),
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
          padding: EdgeInsets.only(bottom: 80.0),
        ),
      ],
    ),
    );
  }
}

AnimatedContainer slider(images, pagePosition, active) {
  double margin = active ? 10 : 20;

  return AnimatedContainer(
    duration: Duration(milliseconds: 500),
    curve: Curves.easeInOutCubic,
    margin: EdgeInsets.all(margin),
    decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(images[pagePosition]))),
  );
}

imageAnimation(PageController animation, images, pagePosition) {
  return AnimatedBuilder(
    animation: animation,
    builder: (context, widget) {
      print(pagePosition);

      return SizedBox(
        width: 200,
        height: 200,
        child: widget,
      );
    },
    child: Container(
      margin: EdgeInsets.all(10),
      child: Image.network(images[pagePosition]),
    ),
  );
}

List<Widget> indicators(imagesLength, currentIndex) {
  return List<Widget>.generate(imagesLength, (index) {
    return Container(
      margin: EdgeInsets.all(7),
      width: 15,
      height: 15,
      decoration: BoxDecoration(
          color: currentIndex == index ? buildMaterialColor(HexColor("#384a5f")) : buildMaterialColor(HexColor("#d47828")),
          shape: BoxShape.circle),
    );
  });
}

buildMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  };
  return MaterialColor(color.value, swatch);
}

//backgroundColor: buildMaterialColor(HexColor("#d47828"))[50],
