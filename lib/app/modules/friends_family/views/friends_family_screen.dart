// Created By Amit Jangid on 05/06/22

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:astro_tak/app/core/config/styles/colors.dart';
import 'package:astro_tak/app/modules/widgets/custom_app_bar.dart';
import 'package:astro_tak/app/core/utils/constants/app_constants.dart';
import 'package:astro_tak/app/modules/widgets/loading/views/base_widget.dart';
import 'package:astro_tak/app/modules/widgets/buttons/primary_border_button.dart';
import 'package:astro_tak/app/modules/friends_family/views/family_profile_screen.dart';

class FriendsFamilyScreen extends StatelessWidget {
  const FriendsFamilyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: CustomAppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                child: PrimaryBorderButton(text: kLogout, onTap: () {}),
              ),
            ],
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back_ios, size: 18, color: kPrimaryDarkColor),
            ),
          ),
          body: Column(
            children: const [
              TabBar(
                labelColor: kPrimaryDarkColor,
                indicatorColor: kPrimaryDarkColor,
                unselectedLabelColor: kBlackShadeColor,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 12),
                tabs: [Tab(text: kMyProfile), Tab(text: kOrderHistory)],
              ),
              Expanded(
                child: SafeArea(top: false, child: TabBarView(children: [FamilyProfileScreen(), SizedBox.shrink()])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
