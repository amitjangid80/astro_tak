// Created By Amit Jangid on 05/06/22

import 'package:flutter/material.dart';
import 'package:astro_tak/app/modules/widgets/asset_image_widget.dart';
import 'package:astro_tak/app/core/utils/constants/assets_constants.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final Widget leading;
  final List<Widget> actions;
  final PreferredSizeWidget? bottom;

  const CustomAppBar({Key? key, this.bottom, required this.leading, required this.actions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      bottom: bottom,
      actions: actions,
      leading: leading,
      centerTitle: true,
      title: const AssetImageWidget(height: 60, iconPath: kIconLogo),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
