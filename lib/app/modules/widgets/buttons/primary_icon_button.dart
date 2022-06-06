// Created By Amit Jangid on 06/06/22

import 'package:flutter/material.dart';
import 'package:astro_tak/app/core/config/styles/colors.dart';
import 'package:astro_tak/app/core/config/styles/text_styles.dart';

class PrimaryIconButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final double? width;
  final Color btnColor;
  final GestureTapCallback? onTap;
  final double borderRadius, verticalPadding, horizontalPadding;

  const PrimaryIconButton({
    Key? key,
    this.width,
    this.borderRadius = 6,
    this.verticalPadding = 6,
    this.horizontalPadding = 12,
    this.btnColor = kPrimaryColor,
    required this.text,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
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
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 12, color: Colors.white),
              Text(
                text,
                textAlign: TextAlign.center,
                style: buttonTextStyle.copyWith(fontSize: 13, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
