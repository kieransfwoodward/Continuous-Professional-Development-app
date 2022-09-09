import 'dart:math';

import 'package:drag_and_drop_lists/drag_and_drop_list_expansion.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:cpd/functions/firebase_functions.dart';

class draggable_list_M2_CollabSkills extends StatefulWidget {
  draggable_list_M2_CollabSkills({
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

class _ListTileExample extends State<draggable_list_M2_CollabSkills> {
  late List<InnerList> _lists;

  //late List<InnerList> _contents;
  @override
  void initState() {
    super.initState();
    // // Generate a list
    // _contents = List.generate(10, (index) {
    //   return DragAndDropList(
    //     header: Text('Header $index'),
    //     children: <DragAndDropItem>[
    //       DragAndDropItem(
    //         child: Text('$index.1'),
    //       ),
    //       DragAndDropItem(
    //         child: Text('$index.2'),
    //       ),
    //       DragAndDropItem(
    //         child: Text('$index.3'),
    //       ),
    //     ],
    //   );
    // });
    late List<String> title = [
      "Conflict resolution",
      "Emotional intelligence",
      "Open-mindedness",
      "Adoptability",
      "Organisation",
      "Active Listening",
      "Communication",
    ];
    late List<String> subtitle = [
      "The informal or formal process that two or more parties use to find "
          "a peaceful solution to their dispute",
      "The capacity to be aware of, control, and express one's emotions, and to "
          "handle interpersonal relationships judiciously and empathetically.",
      "The willingness to consider ideas and opinions that are new or different "
          "to your own.",
      "The quality or extent of being adoptable.",
      "The process of organising or of being organised.",
      "Fully concentrating on what is being said rather than just "
          "passively ‘hearing’ the message of the speaker.",
      "The exchanging of information by speaking, writing, or using some other medium.",
    ];
    _lists = List.generate(7, (outerIndex) {
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
              border: Border.all(),
              borderRadius: BorderRadius.circular(7.0),
              color: buildMaterialColor(HexColor("#d47828"))[50],
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
