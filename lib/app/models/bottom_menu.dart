// Created By Amit Jangid on 05/06/22

import 'package:flutter/material.dart';
import 'package:astro_tak/app/modules/screens.dart';
import 'package:astro_tak/app/core/utils/constants/app_constants.dart';
import 'package:astro_tak/app/core/utils/constants/assets_constants.dart';

class BottomMenu {
  int index;
  String title;
  Widget widget;
  String iconPath;

  BottomMenu({required this.index, required this.title, required this.widget, required this.iconPath});
}

List<BottomMenu> bottomMenuList = [
  BottomMenu(index: 0, title: kHome, widget: const SizedBox.shrink(), iconPath: kIconHome),
  BottomMenu(index: 1, title: kTalk, widget: const SizedBox.shrink(), iconPath: kIconTalk),
  BottomMenu(index: 2, title: kAskQuestion, widget: const AskQuestionScreen(), iconPath: kIconAsk),
  BottomMenu(index: 3, title: kReports, widget: const SizedBox.shrink(), iconPath: kIconReports),
  BottomMenu(index: 4, title: kChat, widget: const SizedBox.shrink(), iconPath: kIconChat),
];
