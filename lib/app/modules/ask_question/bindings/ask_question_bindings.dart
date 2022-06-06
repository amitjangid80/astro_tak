// Created By Amit Jangid on 05/06/22

import 'package:get/get.dart';
import 'package:astro_tak/app/modules/ask_question/rest/ask_question_services.dart';
import 'package:astro_tak/app/modules/ask_question/controllers/ask_question_controller.dart';

class AskQuestionBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AskQuestionServices());
    Get.put(AskQuestionController());
  }
}
