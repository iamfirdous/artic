import 'dart:convert';

import 'package:artic/util/constants.dart';
import 'package:flutter/material.dart';

class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder(
    this.thumb, {
    Key? key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  final String? thumb;
  final double? width;
  final double? height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return thumb != null
        ? Image.memory(
            base64Decode(thumb!.split(',').last),
            width: width,
            height: height,
            fit: fit,
          )
        : Container(
            width: width,
            height: height,
            color: AppColors.grey1,
          );
  }
}
