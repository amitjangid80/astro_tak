// Created By Amit Jangid on 06/06/22

import 'package:get/get.dart';
import 'package:astro_tak/app/modules/friends_family/rest/friends_family_services.dart';
import 'package:astro_tak/app/modules/friends_family/controllers/friends_family_controller.dart';

class FriendsFamilyBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(FriendsFamilyServices());
    Get.put(FriendsFamilyController());
  }
}
