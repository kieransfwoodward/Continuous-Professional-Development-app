import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../custom_divider.dart';
import '../../item.dart';


class drag_and_drop extends StatefulWidget {
  const drag_and_drop({Key? key}) : super(key: key);

  @override
  _drag_and_dropState createState() => _drag_and_dropState();
}

class _drag_and_dropState extends State<drag_and_drop> {
  final AudioCache player = AudioCache(prefix: "assets/audio/");
  late List<ItemModel> items;
  late List<ItemModel> items2;
  late int score;
  late int fullScore;
  late bool gameOver;
  late String appBarText;

  initGameState() {
    score = 0;
    appBarText = 'VocaMatch';
    //List for dragable items
    items = [
      for (String i in <String>[
        'Drawings all showing wrong dimensions.',
        'Accurate setting-out information and specifications not provided before start on site.',
        'Mobile Elevated Working Platform (MWEP) required to gain safe access is not available on site.',
        'Wrong material delivered.',
        'Staff that do not have the required skills or are incompetent.',
        'Temporary labour have not bought into project ethos.',
        'Floor layers laying floors in hall ways and preventing access to rooms with materials.',
        'Bad weather slows down the progress of work on site.',
        'Other trades working in the area needed to carry out installations. ',
        'Supervisor instructing labourers to supply material elsewhere rather than near at hand.'
      ])
        ItemModel(value: i, name: i.toCapitalize(), img: '$i')
    ];
    //List for drop locations
    items2 = [
      for (String i in <String>[
        'Information',
        'Information',
        'Equipment',
        'Materials ',
        'People ',
        'People ',
        'Prior Activity',
        'External Conditions',
        'Safe Space',
        'Shared \nUnderstanding'
      ])
        ItemModel(value: i, name: i.toCapitalize(), img: '$i')
    ];

    fullScore = items.length * 10;
    items.shuffle();
    items2.shuffle();
  }

  @override
  void initState() {
    super.initState();
    initGameState();
  }

  @override
  Widget build(BuildContext context) {
    // Pre-conditions before return widgets
    gameOver = items.isEmpty;
    return SingleChildScrollView(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,

        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              color: Colors.pink.withOpacity(0.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.swipe,
                  color: Colors.white70,
                ),
                const SizedBox(width: 10),
                Text(
                  'Drag and drop from left to right',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(color: Colors.white70),
                ),
              ],
            ),
          ),
         // Expanded(
         //   child:
            ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
             // padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
             children: [
               if (!gameOver) ...[
                 Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                      Column(
                        children: items.map((item) {
                          return Container(
                            margin: const EdgeInsets.all(8),
                            child: Draggable<ItemModel>(
                              data: item,
                              //When the item is being dragged
                              childWhenDragging: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: ClipOval(
                                  child: Text(
                                    item.img,

                                  ),
                                ),
                                radius: MediaQuery.of(context).size.width *
                                    0.076 *
                                    1.75,
                              ),
                              feedback: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: ClipOval(
                                  child: Text(
                                    item.img,

                                  ),
                                ),
                                radius:
                                MediaQuery.of(context).size.width * 0.0775,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: buildMaterialColor(HexColor("#d47828"))[50],
                                ),
                                alignment: Alignment.center,
                                // height: MediaQuery.of(context).size.width / 6.5,
                                width: MediaQuery.of(context).size.width / 3,
                                padding: const EdgeInsets.only(left: 6, top: 12, bottom: 12, right: 6),
                                child: Text(
                                  item.img,

                                ),
                              ),

                            ),
                          );
                        }).toList(growable: false),
                      ),
                      Column(
                        children: items2.map((item) {
                          return DragTarget<ItemModel>(
                            onAccept: (receivedItem) {


                              //if (item.value == receivedItem.value)   Original
                              //if (items == "Drawings all showing wrong dimensions." && items2 == "Information")
                              //if (item.value == "Drawings all showing wrong dimensions." && receivedItem.value== "Information")
                              if (item.value == "Drawings all showing wrong dimensions." && receivedItem.value== "Information") {
                                item.accepting = false;
                                player.play('true.wav');
                                items.remove(receivedItem);
                                items2.remove(item);
                                setState(() => score += 10);
                                if (items.isEmpty) {
                                  _showDialog(
                                    title: '📣 Game Over 📣',
                                    subtitle: generateResult(),
                                  );
                                }
                              } else {
                                item.accepting = false;
                                player.play('false.wav');
                                setState(() => score -= 5);
                              }

                              
                              appBarText = 'Score: $score/$fullScore';
                            },
                            onWillAccept: (receivedItem) {
                              setState(() => item.accepting = true);
                              return true;
                            },
                            onLeave: (receivedItem) {
                              setState(() => item.accepting = false);
                            },
                            builder: (context, acceptedItems, rejectedItems) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: buildMaterialColor(HexColor("#d47828"))[300],
                                ),
                                alignment: Alignment.center,
                                padding: const EdgeInsets.only(left: 6, top: 12, bottom: 12, right: 6),
                                width: MediaQuery.of(context).size.width / 2.5,
                                margin: const EdgeInsets.all(8),
                                child: Text(item.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                        color: Colors.black
                                            .withOpacity(0.60))),
                              );
                            },
                          );
                        }).toList(growable: false),
                      ),
                   ],
                 ),
               ],
             ],
           ),
       //   ),
        ],
        ),
    );
  }

  //Methods:
  String generateResult() {
    if (score == fullScore) {
      player.play('success.wav');
      return 'Awesome!';
    } else {
      player.play('try_again.wav');
      return 'Try again';
    }
  }

  void _showDialog({required String title, required String subtitle}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor:
          Theme.of(context).scaffoldBackgroundColor.withOpacity(0.90),
          title: Column(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 25,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              CustomDivider(),
            ],
          ),
          content: Text(subtitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline3),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                setState(() => initGameState());
              },
              child: Container(
                // padding:
                // const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text('OK', style: TextStyle(fontSize: 18)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 60.0),
            ),
          ],
        );
      },
    );
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
  return MaterialColor(color.value, swatch);}
}

extension StringExtension on String {
  String toCapitalize() =>
      "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
}
