// Created By Amit Jangid on 11/06/22

import 'dart:async';

import 'package:get/get.dart';
import 'package:flutter/material.dart';

class TimerController extends SuperController {
  Timer? mTimer;
  Color containerColor = Colors.white;

  @override
  void onReady() {
    super.onReady();

    mTimer = Timer(const Duration(minutes: 5), () {});

    if (mTimer!.tick <= 0) {
      mTimer!.cancel();
      _showDialogBox();
    }

    if (mTimer!.tick < 60) {
      containerColor = Colors.red;
      update(['Timer']);
    }
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {
    debugPrint('timer is paused');
  }

  @override
  void onResumed() {
    debugPrint('timer is resumed');
  }

  void _showDialogBox() {
    showDialog(
      context: Get.context!,
      builder: (_) {
        return AlertDialog(
          title: const Text('Dialog'),
          content: const Text('Timer completed'),
          actions: [ElevatedButton(onPressed: () => Get.back(), child: const Text('Ok'))],
        );
      },
    );
  }
}
