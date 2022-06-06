// Created By Amit Jangid on 05/06/22

import 'package:get/get.dart';
import 'package:astro_tak/app/modules/widgets/loading/controllers/loading_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(LoadingController());
  }
}
