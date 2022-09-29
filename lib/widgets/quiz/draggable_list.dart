import 'dart:math';

import 'package:drag_and_drop_lists/drag_and_drop_list_expansion.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:cpd/functions/firebase_functions.dart';

class ExpansionTileExample extends StatefulWidget {
  ExpansionTileExample({
    Key? key,
    required this.moduleId,
    required this.questionNumber,
    required this.data,
  }) : super(key: key);

  final String moduleId;
  final String questionNumber;
  final Map<String, dynamic> data;

  @override
  _ListTileExample createState() => _ListTileExample();
}

class InnerList {
  String title;
  String subtitle;

  InnerList({required this.title, required this.subtitle});
}

class _ListTileExample extends State<ExpansionTileExample> {
  late List<InnerList> _lists;

  //late List<InnerList> _contents;
  @override
  void initState() {
    super.initState();
    late List<String> title = [
      "Ideas and Judgment",
      "Reporting Facts/ Gossip",
      "Peak Rapport",
      "Cliché/ Ritual",
      "Feelings and Emotions",
    ];
    late List<String> subtitle = [
      "This level of communication is when individuals are giving their opinion and judgments on the situation. "
          "For example, I believe if we were to recruit in the technical area, it will give us a stronger "
          "presence.",
      "This is when you are relaying information from someone else, not owning the conversation. For example, "
          "we might say people have said to me that your team are feeling frustrated, so it’s information, "
          "whether it’s factual or it’s gossip.",
      "This idea moves away from facts, rituals and safe subjects to explore hopes, fears, feelings and passions.",
      "This is the kind of communication where you pass the time of day, or talk about safe subjects such as "
          "weather, sports, or TV.",
      "Someone is prepared to say what they think and feel. This usually includes giving feedback, for "
          "example when you stop imputing at team meetings, I’m unclear what you think, and I become confused.",
    ];
    _lists = List.generate(5, (outerIndex) {
      return InnerList(
        title: title[outerIndex],
        subtitle: subtitle[outerIndex],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DragAndDropLists(
      children: List.generate(_lists.length, (index) => _buildList(index)),
      onItemReorder: _onItemReorder,
      onListReorder: _onListReorder,
      // listGhost is mandatory when using expansion tiles to prevent multiple widgets using the same globalkey
      listGhost: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 70.0),
            decoration: BoxDecoration(
              border: Border.all(
                  // color: Colors.purple,
                  // width: 3,
              ),
              borderRadius: BorderRadius.circular(7.0),
              color: buildMaterialColor(HexColor("#d47828")),
            ),
            child: Icon(Icons.add_box),
          ),
        ),
      ),
    ));
  }

  _buildList(int outerIndex) {
    var innerList = _lists[outerIndex];
    return DragAndDropListExpansion(
      //Enter the title into the box
      title: Text('${innerList.title}'),
      //Add an Icon to the left hand side of the box
      leading: Transform.rotate(
        angle: 90 * pi / 180,
        child: Icon(Icons.multiple_stop_rounded),
      ),
      //Enter text to the drop down feature
      children: List.generate(1, (index) => _buildItem(innerList.subtitle)),
      listKey: ObjectKey(innerList),
    );
  }

  _buildItem(String item) {
    return DragAndDropItem(
      child: ListTile(
        title: Text(item),
      ),
    );
  }

  _onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      //var movedItem = _lists[oldListIndex].subtitle.removeAt(oldItemIndex);
      //_lists[newListIndex].subtitle.insert(newItemIndex, movedItem);
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
    }
    ;
    return MaterialColor(color.value, swatch);
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    setState(() {
      var movedList = _lists.removeAt(oldListIndex);
      _lists.insert(newListIndex, movedList);
    });
  }
}
