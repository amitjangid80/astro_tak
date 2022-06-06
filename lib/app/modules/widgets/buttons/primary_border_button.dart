// Created By Amit Jangid on 05/06/22

import 'package:flutter/material.dart';
import 'package:astro_tak/app/core/config/styles/colors.dart';
import 'package:astro_tak/app/core/config/styles/text_styles.dart';

class PrimaryBorderButton extends StatelessWidget {
  final String text;
  final Color btnColor;
  final GestureTapCallback? onTap;
  final double borderRadius, verticalPadding, horizontalPadding;

  const PrimaryBorderButton({
    Key? key,
    this.borderRadius = 6,
    this.verticalPadding = 6,
    this.horizontalPadding = 18,
    this.btnColor = kPrimaryDarkColor,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 2, color: btnColor),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
          child: Text(text, textAlign: TextAlign.center, style: buttonTextStyle.copyWith(color: btnColor)),
        ),
      ),
    );
  }
}
