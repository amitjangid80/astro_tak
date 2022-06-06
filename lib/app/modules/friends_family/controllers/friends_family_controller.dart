// Created By Amit Jangid on 05/06/22

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:astro_tak/app/models/family/family.dart';
import 'package:astro_tak/app/core/config/styles/colors.dart';
import 'package:astro_tak/app/core/utils/constants/app_constants.dart';
import 'package:astro_tak/app/modules/widgets/buttons/primary_button.dart';
import 'package:astro_tak/app/modules/friends_family/rest/friends_family_services.dart';
import 'package:astro_tak/app/modules/widgets/loading/controllers/loading_controller.dart';

class FriendsFamilyController extends GetxController {
  static FriendsFamilyController get to => Get.find<FriendsFamilyController>();

  int selectedTabIndex = 0;
  bool showAddProfileScreen = false;

  Family? mFamilyEdit;
  List<Family> familiesList = [];

  @override
  void onReady() {
    super.onReady();

    // calling get families list method
    getFamiliesList();
  }

  getFamiliesList() async {
    LoadingController.to.isLoading = true;

    // calling get families list api method
    familiesList = await FriendsFamilyServices.to.getFamiliesListApi();
    update([kFriendsFamilyProfile]);

    LoadingController.to.isLoading = false;
  }

  onAddNewProfile() {
    showAddProfileScreen = true;
    update([kFriendsFamilyProfile]);
  }

  onEditProfile(Family family) {
    mFamilyEdit = family;
    showAddProfileScreen = true;
    update([kFriendsFamilyProfile]);
  }

  onProfileDelete(Family family) {
    showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Do your really want to Delete?'),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      text: kYes,
                      showBorder: false,
                      verticalPadding: 8,
                      textColor: Colors.white,
                      btnColor: kPrimaryDarkColor,
                      onTap: () {
                        // for closing the dialog
                        Get.back();

                        // calling delete relative method
                        _deleteRelative(family.uuid);
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: PrimaryButton(
                      text: kNo,
                      showBorder: false,
                      verticalPadding: 8,
                      onTap: () => Get.back(),
                      textColor: Colors.white,
                      btnColor: kPrimaryDarkColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  _deleteRelative(String uuid) async {
    LoadingController.to.isLoading = true;

    // calling delete relative api method
    final result = await FriendsFamilyServices.to.deleteRelativeApi(uuid: uuid);
    Fluttertoast.showToast(msg: result, gravity: ToastGravity.CENTER, toastLength: Toast.LENGTH_LONG);

    LoadingController.to.isLoading = false;

    // calling get families list method
    getFamiliesList();
  }

  onBackPressed() {
    mFamilyEdit = null;
    showAddProfileScreen = false;

    // calling get families list method
    getFamiliesList();
  }
}
