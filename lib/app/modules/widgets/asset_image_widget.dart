// Created By Amit Jangid on 05/06/22

import 'package:flutter/material.dart';
import 'package:astro_tak/app/core/utils/constants/assets_constants.dart';

class AssetImageWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final String iconPath;
  final Color? iconColor;

  const AssetImageWidget({Key? key, this.width, this.iconColor, this.height = 24, required this.iconPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset("$kIconAssetPath$iconPath", width: width, height: height, color: iconColor);
  }
}
