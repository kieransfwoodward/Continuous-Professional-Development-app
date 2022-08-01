import 'package:cpd/styling/custom_border.dart';
import 'package:cpd/styling/size_params.dart';
import "package:flutter/material.dart";

// Module image, which adjusts to the appropriate size dynamically

//Different types of images as an enumerator
enum ImageType { leaderboard, module, banner, banner4 }

class ModuleBannerImage extends StatelessWidget {
  const ModuleBannerImage(
      {Key? key, required this.imagePath, required this.imageType})
      : super(key: key);
  final String imagePath;
  final ImageType imageType;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: CustomBorder().imageDecoration(context),
      // Dynamic width and height depending on the image type
      width: imageType == ImageType.banner
          ? SizeParams().widthWithPadding(context)
          : imageType == ImageType.banner4
          ? SizeParams().widthWithPadding(context)
          : imageType == ImageType.leaderboard
              ? SizeParams().leaderboardImageSize(context)
              : imageType == ImageType.module
                  ? SizeParams().itemImageWidth(context)
                  : 0,
      height: imageType == ImageType.banner
          ? SizeParams().quarterHeight(context)
          : imageType == ImageType.banner4
          ? SizeParams().quarterHeight(context)*2
          : imageType == ImageType.leaderboard
              ? SizeParams().leaderboardImageSize(context)
              : imageType == ImageType.module
                  ? SizeParams().itemImageWidth(context)
                  : 0,
      child: InteractiveViewer(
       // borderRadius: CustomBorder().borderRadius,
        child: imagePath.isEmpty
            ? Container()
            : Image.network(
                imagePath,
                fit: BoxFit.fitHeight,
                alignment: Alignment.center,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  return loadingProgress == null
                      ? child
                      : Center(
                          child: imageType == InteractiveViewer
                              ? LinearProgressIndicator(
                                  value: _getLoadingValue(loadingProgress),
                                )
                              : Center(
                                  child: CircularProgressIndicator(
                                    value: _getLoadingValue(loadingProgress),
                                  ),
                                ),
                        );
                },
              ),
      ),
    );
  }

  double? _getLoadingValue(ImageChunkEvent loadingProgress) {
    return loadingProgress.expectedTotalBytes != null
        ? loadingProgress.cumulativeBytesLoaded /
            loadingProgress.expectedTotalBytes!
        : null;
  }
}
