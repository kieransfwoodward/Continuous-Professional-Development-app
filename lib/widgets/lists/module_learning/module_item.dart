import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cpd/functions/module_functions.dart';
import 'package:cpd/screens/module_content.dart';
import 'package:cpd/styling/custom_border.dart';
import 'package:cpd/widgets/image/module_banner_image.dart';
import 'package:cpd/widgets/lists/module_learning/custom_progress_indicator.dart';
import 'package:cpd/widgets/lists/module_learning/module_tile_details.dart';
import 'package:flutter/material.dart';

// Details each module

class ModuleItem extends StatefulWidget {
  const ModuleItem({
    Key? key,
    required this.documentId,
    required this.reference,
    required this.data,
  }) : super(key: key);

  final String documentId;
  final DocumentReference reference;
  final Map<String, dynamic> data;

  @override
  State<ModuleItem> createState() => _ModuleItemState();
}

class _ModuleItemState extends State<ModuleItem> {
  int? _duration, _totalPoints;

  // Gets the number of of questions and uses this to calculate the duration of the module
  // Also calculates the total points for that module
  Future<void> _getQuestionCount() async {
    CollectionReference reference = widget.reference.collection("questions");
    ModuleFunctions().calculateQuestions(ref: reference).then(
          (duration) async => await ModuleFunctions()
              .calculateTotalPoints(ref: reference)
              .then((points) {
            if (mounted) {
              setState(() {
                _totalPoints = points;
                _duration = ModuleFunctions().calculateQuizTime(
                  duration,
                );
              });
            }
          }),
        );
  }

  @override
  void initState() {
    _getQuestionCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: CustomBorder().borderRadius,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ModuleBannerImage(
            imagePath: widget.data["image_url"],
            imageType: ImageType.module,
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.data["name"],
                          style: Theme.of(context).textTheme.headline6),
                      CustomProgressIndicator(),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 4.0,
                      bottom: 8.0,
                    ),
                    child: (_duration != null && _totalPoints != null)
                        ? ModuleTileDetails(
                            duration: _duration!,
                            points: _totalPoints!,
                            largeItem: false,
                          )
                        : const LinearProgressIndicator(),
                  ),
                  Text(
                    widget.data["subtitle"],
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ModuleContent(
            documentId: widget.documentId,
            reference: widget.reference,
            data: widget.data,
            duration: _duration!,
            points: _totalPoints!,
          ),
        ),
      ),
    );
  }
}
