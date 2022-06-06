// Created By Amit Jangid on 06/06/22

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:astro_tak/app/core/utils/utils.dart';
import 'package:astro_tak/app/models/family/family.dart';
import 'package:astro_tak/app/core/config/styles/colors.dart';
import 'package:astro_tak/app/core/config/styles/text_styles.dart';
import 'package:astro_tak/app/core/utils/constants/app_constants.dart';
import 'package:astro_tak/app/modules/widgets/buttons/primary_button.dart';
import 'package:astro_tak/app/modules/widgets/buttons/primary_icon_button.dart';
import 'package:astro_tak/app/modules/friends_family/views/add_profile_screen.dart';
import 'package:astro_tak/app/modules/friends_family/controllers/friends_family_controller.dart';

class FamilyProfileScreen extends StatelessWidget {
  const FamilyProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FriendsFamilyController>(
      id: kFriendsFamilyProfile,
      builder: (controller) {
        return SingleChildScrollView(
          padding: const EdgeInsets.only(top: 8, left: 12, right: 12),
          child: Column(
            children: [
              const _HeaderWidget(),
              if (controller.showAddProfileScreen) ...[
                const AddProfileScreen(),
              ] else ...[
                const _WalletBalanceWidget(),
                const _FamilyRelativeHeader(),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.familiesList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(top: 6, bottom: 36),
                  itemBuilder: (context, position) {
                    final Family family = controller.familiesList[position];

                    return _FamilyRelativeItem(family: family, controller: controller);
                  },
                ),
                PrimaryIconButton(
                  width: 160,
                  icon: Icons.add,
                  verticalPadding: 10,
                  text: kAddNewProfile,
                  onTap: controller.onAddNewProfile,
                ),
                const SizedBox(height: 24),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: const Text(kBasicProfile, style: textStyle13Normal, textAlign: TextAlign.center),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: const BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            child: Text(
              kFriendsFamilyProfile,
              textAlign: TextAlign.center,
              style: textStyle13Normal.copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

class _WalletBalanceWidget extends StatelessWidget {
  const _WalletBalanceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 18),
      decoration: const BoxDecoration(color: kLightBlueColor, borderRadius: BorderRadius.all(Radius.circular(6))),
      child: Row(
        children: [
          const Icon(Icons.account_balance_wallet, color: kBlueColor),
          const SizedBox(width: 6),
          Text('$kWalletBalance $kRupeeSymbol 0', style: textStyle12Normal.copyWith(color: kBlueColor)),
          const SizedBox(width: 6),
          PrimaryButton(text: kAddMoney, onTap: () {}),
        ],
      ),
    );
  }
}

class _FamilyRelativeHeader extends StatelessWidget {
  const _FamilyRelativeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(kName, style: textStyle12Normal.copyWith(color: kBlueColor))),
          const SizedBox(width: 12),
          Expanded(flex: 2, child: Text(kDOB, style: textStyle12Normal.copyWith(color: kBlueColor))),
          const SizedBox(width: 12),
          Expanded(child: Text(kTOB, style: textStyle12Normal.copyWith(color: kBlueColor))),
          const SizedBox(width: 12),
          Expanded(flex: 2, child: Text(kRelation, style: textStyle12Normal.copyWith(color: kBlueColor))),
          const SizedBox(width: 12),
          const Expanded(flex: 2, child: SizedBox.shrink()),
        ],
      ),
    );
  }
}

class _FamilyRelativeItem extends StatelessWidget {
  final Family family;
  final FriendsFamilyController controller;

  const _FamilyRelativeItem({Key? key, required this.family, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: kBgColor),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        boxShadow: [BoxShadow(blurRadius: 10, spreadRadius: 1, color: Colors.grey[200]!)],
      ),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(family.fullName, style: textStyle11Normal)),
          const SizedBox(width: 12),
          Expanded(flex: 2, child: Text(getDob(family.birthDetails), style: textStyle11Normal)),
          const SizedBox(width: 12),
          Expanded(child: Text(getTob(family.birthDetails), style: textStyle11Normal)),
          const SizedBox(width: 12),
          Expanded(flex: 2, child: Text(family.relation, style: textStyle11Normal)),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => controller.onEditProfile(family),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Icon(Icons.edit, color: kPrimaryColor),
                  ),
                ),
                InkWell(
                  onTap: () => controller.onProfileDelete(family),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Icon(Icons.delete, color: kPrimaryColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
