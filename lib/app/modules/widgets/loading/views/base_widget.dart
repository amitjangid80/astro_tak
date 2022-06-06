// Created By Amit Jangid on 05/06/22

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:astro_tak/app/modules/widgets/loading/controllers/loading_controller.dart';

class BaseWidget extends StatelessWidget {
  final Widget child;

  const BaseWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            child,
            if (LoadingController.to.isLoading) ...[
              Container(color: Colors.white54, child: const Center(child: CircularProgressIndicator())),
            ],
          ],
        ),
      ),
    );
  }
}
