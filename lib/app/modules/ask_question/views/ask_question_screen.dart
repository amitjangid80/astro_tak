// Created By Amit Jangid on 05/06/22

import 'dart:math';

import 'package:astro_tak/app/models/bottom_menu.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:astro_tak/app/models/ask_question/category.dart';
import 'package:astro_tak/app/core/config/styles/colors.dart';
import 'package:astro_tak/app/core/config/routes/routes.dart';
import 'package:astro_tak/app/modules/widgets/custom_app_bar.dart';
import 'package:astro_tak/app/core/config/styles/text_styles.dart';
import 'package:astro_tak/app/modules/widgets/asset_image_widget.dart';
import 'package:astro_tak/app/core/utils/constants/app_constants.dart';
import 'package:astro_tak/app/core/utils/constants/assets_constants.dart';
import 'package:astro_tak/app/modules/widgets/buttons/primary_button.dart';
import 'package:astro_tak/app/modules/widgets/loading/views/base_widget.dart';
import 'package:astro_tak/app/modules/ask_question/controllers/ask_question_controller.dart';

class AskQuestionScreen extends StatelessWidget {
  const AskQuestionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AskQuestionController>(
      id: kAskAQuestion,
      builder: (controller) {
        return BaseWidget(
          child: Scaffold(
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom: 42),
              child: FloatingActionButton(
                onPressed: () {},
                child: const Icon(Icons.menu, color: Colors.white),
              ),
            ),
            appBar: CustomAppBar(
              leading: IconButton(
                onPressed: () {},
                icon: const AssetImageWidget(height: 18, iconPath: kIconHamburger),
              ),
              actions: [
                IconButton(
                  icon: const AssetImageWidget(iconPath: kIconProfile),
                  onPressed: () => Get.toNamed(kFriendFamilyRoute, arguments: {kIsEdit: true, kFamily: null}),
                ),
              ],
            ),
            bottomNavigationBar: _BottomNavigationMenu(controller: controller),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _HeaderWidget(),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(kAskAQuestion, style: textStyle14Bold),
                              const SizedBox(height: 6),
                              const Text(kQuestionDetails, style: textStyle13Normal),
                              const SizedBox(height: 12),
                              const Text(kChooseCategory, style: textStyle14Bold),
                              const SizedBox(height: 6),
                              if (controller.categoriesList.isNotEmpty) ...[
                                _CategoryDropDown(controller: controller),
                              ],
                              const SizedBox(height: 24),
                              Form(
                                key: controller.formKey,
                                child: TextFormField(
                                  maxLines: 4,
                                  maxLength: 150,
                                  validator: controller.validateQuestion,
                                  controller: controller.suggestionController,
                                  decoration: const InputDecoration(hintText: kTypeQuestionHere),
                                ),
                              ),
                              const SizedBox(height: 12),
                              const Text(kIdeasWhatToAsk, style: textStyle14Bold),
                              if (controller.mSelectedCategory != null) ...[
                                _SuggestionsListWidget(controller: controller),
                              ],
                              const Text(kSeekAccurateAnswer, style: textStyle13Normal),
                              const _DescriptionWidget(),
                              const SizedBox(height: 48),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (controller.mSelectedCategory != null) ...[
                  _FooterWidget(controller: controller),
                ],
              ],
            ),
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
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(color: kBlueColor),
      child: Row(
        children: [
          Expanded(
            child: Text('$kWalletBalance : $kRupeeSymbol 0', style: textStyle16Bold.copyWith(color: Colors.white)),
          ),
          const SizedBox(width: 12),
          PrimaryButton(text: kAddMoney, onTap: () {}),
        ],
      ),
    );
  }
}

class _BottomNavigationMenu extends StatelessWidget {
  final AskQuestionController controller;

  const _BottomNavigationMenu({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      selectedFontSize: 11,
      unselectedFontSize: 10,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: kPrimaryDarkColor,
      currentIndex: controller.currentIndex,
      onTap: controller.onBottomMenuSelected,
      items: bottomMenuList
          .map<BottomNavigationBarItem>(
            (bottomMenu) => BottomNavigationBarItem(
              label: bottomMenu.title,
              icon: AssetImageWidget(height: 20, iconColor: Colors.grey, iconPath: bottomMenu.iconPath),
              activeIcon: AssetImageWidget(height: 22, iconColor: kPrimaryDarkColor, iconPath: bottomMenu.iconPath),
            ),
          )
          .toList(),
    );
  }
}

class _CategoryDropDown extends StatelessWidget {
  final AskQuestionController controller;

  const _CategoryDropDown({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      color: Colors.white,
      type: MaterialType.card,
      child: DropdownButton<Category>(
        isExpanded: true,
        underline: const SizedBox.shrink(),
        value: controller.mSelectedCategory,
        // calling on category change method
        onChanged: controller.onCategoryChanged,
        items: controller.categoriesList
            .map<DropdownMenuItem<Category>>(
              (category) => DropdownMenuItem<Category>(
                value: category,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Text(category.name, style: textStyle14Normal),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _SuggestionsListWidget extends StatelessWidget {
  final AskQuestionController controller;

  const _SuggestionsListWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.mSelectedCategory!.suggestionsList.length,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
      itemBuilder: (context, position) {
        final String suggestion = controller.mSelectedCategory!.suggestionsList[position];

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () => controller.onSuggestionSelected(suggestion),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationZ(pi / 4),
                      child: Material(
                        elevation: 16,
                        type: MaterialType.card,
                        child: Container(
                          width: 20,
                          height: 20,
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(color: kPrimaryDarkColor),
                          child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationZ(-(pi / 4)),
                            child: const AssetImageWidget(
                              iconPath: kIconQuestion,
                              iconColor: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(child: Text(suggestion, style: textStyle14Normal))
                  ],
                ),
              ),
            ),
            const Divider(height: 1, color: kBlackShadeColor),
          ],
        );
      },
    );
  }
}

class _DescriptionWidget extends StatelessWidget {
  const _DescriptionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryLightColor,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _BulletPointWidget(text: kPersonalizedResponses),
          SizedBox(height: 3),
          _BulletPointWidget(text: kQualifiedAndExperienced),
          SizedBox(height: 3),
          _BulletPointWidget(text: kSeekAnswers),
          SizedBox(height: 3),
          _BulletPointWidget(text: kOurTeamOfVedic),
        ],
      ),
    );
  }
}

class _BulletPointWidget extends StatelessWidget {
  final String text;

  const _BulletPointWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 7,
          height: 7,
          margin: const EdgeInsets.only(top: 4),
          decoration: const BoxDecoration(color: kPrimaryDarkColor, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Expanded(child: Text(text, style: textStyle12Normal)),
      ],
    );
  }
}

class _FooterWidget extends StatelessWidget {
  final AskQuestionController controller;

  const _FooterWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(color: kBlueColor, borderRadius: BorderRadius.all(Radius.circular(6))),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '$kRupeeSymbol ${controller.mSelectedCategory!.price} '
              '(${controller.suggestionController.value.text.isNotEmpty ? 1 : 0} Question on ${controller.mSelectedCategory!.name})',
              style: textStyle13Normal.copyWith(color: Colors.white),
            ),
          ),
          const SizedBox(width: 12),
          PrimaryButton(text: kAskNow, onTap: () {}),
        ],
      ),
    );
  }
}
