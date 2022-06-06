// Created By Amit Jangid on 05/06/22

import 'package:get/get.dart';

class LoadingController extends GetxController {
  static LoadingController get to => Get.find<LoadingController>();

  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  set isLoading(isLoading) => _isLoading.value = isLoading;
}
