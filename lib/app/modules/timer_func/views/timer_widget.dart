// Created By Amit Jangid on 11/06/22

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:astro_tak/app/modules/timer_func/controllers/timer_controller.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<TimerController>(
        id: 'Timer',
        init: TimerController(),
        builder: (controller) {
          return Container(
            color: controller.containerColor,
            child: Text('Timer value is: ${controller.mTimer?.tick ?? 0}'),
          );
        },
      ),
    );
  }
}
