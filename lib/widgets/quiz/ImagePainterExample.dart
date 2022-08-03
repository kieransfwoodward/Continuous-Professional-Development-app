import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_painter/image_painter.dart';
import 'package:path_provider/path_provider.dart';

import 'dutch_text_delegate.dart';

class ImagePainterExample extends StatefulWidget {
  @override
  _ImagePainterExampleState createState() => _ImagePainterExampleState();
}

class _ImagePainterExampleState extends State<ImagePainterExample> {
  final _imageKey = GlobalKey<ImagePainterState>();
  final _key = GlobalKey<ScaffoldState>();

  // void saveImage() async {
  //   final image = await _imageKey.currentState.exportImage();
  //   final directory = (await getApplicationDocumentsDirectory()).path;
  //   await Directory('$directory/sample').create(recursive: true);
  //   final fullPath =
  //       '$directory/sample/${DateTime.now().millisecondsSinceEpoch}.png';
  //   final imgFile = File('$fullPath');
  //   imgFile.writeAsBytesSync(image);
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       backgroundColor: Colors.grey[700],
  //       padding: const EdgeInsets.only(left: 10),
  //       content: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           const Text("Image Exported successfully.",
  //               style: TextStyle(color: Colors.white)),
  //           TextButton(
  //             onPressed: () => OpenFile.open("$fullPath"),
  //             child: Text(
  //               "Open",
  //               style: TextStyle(
  //                 color: Colors.blue[200],
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // key: _key,
      // appBar: AppBar(
      //   title: const Text("Design A Tree Swing"),
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.save_alt),
      //       onPressed: saveImage,
      //     )
      //   ],
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ImagePainter.asset(
            "assets/TreeSwing.PNG",
            key: _imageKey,
            scalable: true,
            initialStrokeWidth: 6,
            textDelegate: DutchTextDelegate(),
            initialColor: Colors.red,
            initialPaintMode: PaintMode.freeStyle,
        ),
      ]),
    );
  }
}
