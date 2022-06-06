// Created By Amit Jangid on 05/06/22

import 'package:flutter/material.dart';
import 'package:astro_tak/app/core/config/styles/colors.dart';
import 'package:astro_tak/app/core/config/styles/text_styles.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final double? width;
  final bool showBorder;
  final Color btnColor, textColor;
  final GestureTapCallback? onTap;
  final double borderRadius, verticalPadding, horizontalPadding;

  const PrimaryButton({
    Key? key,
    this.width,
    this.borderRadius = 6,
    this.showBorder = true,
    this.verticalPadding = 6,
    this.textColor = kBlueColor,
    this.horizontalPadding = 12,
    this.btnColor = Colors.white,
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
          width: width,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
          decoration: BoxDecoration(
            color: btnColor,
            border: showBorder ? Border.all(color: kBlackColor) : null,
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
          child: Text(text, style: buttonTextStyle.copyWith(color: textColor), textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
