// Created By Amit Jangid on 06/06/22

import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:astro_tak/app/models/family/relation.dart';
import 'package:astro_tak/app/core/config/styles/colors.dart';
import 'package:astro_tak/app/models/family/place_of_birth.dart';
import 'package:astro_tak/app/core/config/styles/text_styles.dart';
import 'package:astro_tak/app/core/utils/constants/app_constants.dart';
import 'package:astro_tak/app/modules/widgets/buttons/primary_button.dart';
import 'package:astro_tak/app/modules/friends_family/controllers/add_profile_controller.dart';
import 'package:astro_tak/app/modules/friends_family/controllers/friends_family_controller.dart';

class AddProfileScreen extends StatelessWidget {
  const AddProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddProfileController>(
      id: kAddNewProfile,
      init: AddProfileController(),
      builder: (controller) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 3),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: FriendsFamilyController.to.onBackPressed,
                      icon: const Icon(Icons.arrow_back_ios, size: 24, color: kBlackColor),
                    ),
                    const Text(kAddNewProfile, style: textStyle16Normal),
                  ],
                ),
                //#region Name Field
                const SizedBox(height: 18),
                const Text(kName, style: textStyle14Normal),
                const SizedBox(height: 6),
                TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.name,
                  validator: controller.validateName,
                  controller: controller.nameController,
                  textCapitalization: TextCapitalization.words,
                ),
                //#endregion Name Field
                //#region Date of Birth Field
                const SizedBox(height: 12),
                const Text(kDateOfBirth, style: textStyle14Normal),
                const SizedBox(height: 6),
                Row(
                  children: [
                    //#region DD Field
                    Expanded(
                      child: TextFormField(
                        maxLength: 2,
                        autocorrect: false,
                        validator: controller.validateDD,
                        controller: controller.dobDayController,
                        decoration: const InputDecoration(hintText: kDD),
                        keyboardType: const TextInputType.numberWithOptions(),
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      ),
                    ),
                    //#endregion DD Field
                    const SizedBox(width: 12),
                    //#region MM Field
                    Expanded(
                      child: TextFormField(
                        maxLength: 2,
                        autocorrect: false,
                        validator: controller.validateMM,
                        controller: controller.dobMonthController,
                        decoration: const InputDecoration(hintText: kMM),
                        keyboardType: const TextInputType.numberWithOptions(),
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      ),
                    ),
                    //#endregion MM Field
                    const SizedBox(width: 12),
                    //#region YYYY Field
                    Expanded(
                      child: TextFormField(
                        maxLength: 4,
                        autocorrect: false,
                        validator: controller.validateYYYY,
                        controller: controller.dobYearController,
                        decoration: const InputDecoration(hintText: kYYYY),
                        keyboardType: const TextInputType.numberWithOptions(),
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      ),
                    ),
                    //#endregion YYYY Field
                  ],
                ),
                //#endregion Date of Birth Field
                //#region Time of Birth Field
                const SizedBox(height: 12),
                const Text(kTimeOfBirth, style: textStyle14Normal),
                const SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //#region HH Field
                    Expanded(
                      child: TextFormField(
                        maxLength: 2,
                        autocorrect: false,
                        validator: controller.validateHH,
                        controller: controller.tobHourController,
                        decoration: const InputDecoration(hintText: kHH),
                        keyboardType: const TextInputType.numberWithOptions(),
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      ),
                    ),
                    //#endregion HH Field
                    const SizedBox(width: 12),
                    //#region MM Field
                    Expanded(
                      child: TextFormField(
                        maxLength: 2,
                        autocorrect: false,
                        validator: controller.validateMM,
                        controller: controller.tobMinuteController,
                        decoration: const InputDecoration(hintText: kMM),
                        keyboardType: const TextInputType.numberWithOptions(),
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      ),
                    ),
                    //#endregion MM Field
                    const SizedBox(width: 12),
                    //#region AM PM Field
                    Expanded(
                      child: Material(
                        elevation: 4,
                        type: MaterialType.card,
                        borderRadius: const BorderRadius.all(Radius.circular(6)),
                        child: Row(
                          children: [
                            Expanded(
                              child: _MeridiemWidget(
                                meridiem: kAM,
                                onTap: controller.onAmPmSelected,
                                isSelected: controller.isAmSelected,
                              ),
                            ),
                            Expanded(
                              child: _MeridiemWidget(
                                meridiem: kPM,
                                onTap: controller.onAmPmSelected,
                                isSelected: !controller.isAmSelected,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //#endregion AM PM Field
                  ],
                ),
                //#endregion Time of Birth Field
                //#region Place of Birth Field
                const SizedBox(height: 12),
                const Text(kPlaceOfBirth, style: textStyle14Normal),
                const SizedBox(height: 6),
                TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  validator: controller.validatePlaceOfBirth,
                  textCapitalization: TextCapitalization.words,
                  controller: controller.placeOfBirthController,
                  onChanged: (placeOfBirth) => controller.searchPlaceOfBirth = placeOfBirth,
                ),
                if (controller.placeOfBirthList.isNotEmpty) ...[
                  SizedBox(
                    height: 300,
                    child: Material(
                      elevation: 2,
                      type: MaterialType.card,
                      shadowColor: Colors.grey[300],
                      child: ListView.separated(
                        padding: const EdgeInsets.only(top: 12),
                        itemCount: controller.placeOfBirthList.length,
                        separatorBuilder: (context, position) => const Divider(color: kBlackShadeColor),
                        itemBuilder: (context, position) {
                          final PlaceOfBirth placeOfBirth = controller.placeOfBirthList[position];

                          return GestureDetector(
                            onTap: () => controller.onPlaceOfBirthSelected(placeOfBirth),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                              child: Text(placeOfBirth.placeName, style: textStyle12Normal),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
                //#endregion Place of Birth Field
                //#region Gender & Relation Field
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //#region Gender Field
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(kGender, style: textStyle14Normal),
                          const SizedBox(height: 6),
                          DropdownButtonFormField<String>(
                            value: controller.mSelectedGender,
                            validator: controller.validateGender,
                            onChanged: controller.onGenderSelected,
                            items: const [
                              DropdownMenuItem(value: kGenderMale, child: Text(kGenderMale)),
                              DropdownMenuItem(value: kGenderFemale, child: Text(kGenderFemale)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    //#endregion Gender Field
                    const SizedBox(width: 12),
                    //#region Relation Field
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(kRelation, style: textStyle14Normal),
                          const SizedBox(height: 6),
                          DropdownButtonFormField<Relation>(
                            value: controller.mSelectedRelation,
                            validator: controller.validateRelation,
                            onChanged: controller.onRelationSelected,
                            items: relationList
                                .map<DropdownMenuItem<Relation>>((relation) =>
                                    DropdownMenuItem<Relation>(value: relation, child: Text(relation.relation)))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                    //#endregion Relation Field
                  ],
                ),
                //#endregion Gender & Relation Field
                //#region Save changes Button
                const SizedBox(height: 24),
                Center(
                  child: PrimaryButton(
                    width: 140,
                    showBorder: false,
                    text: kSaveChanges,
                    verticalPadding: 12,
                    btnColor: kPrimaryColor,
                    textColor: Colors.white,
                    onTap: controller.saveChanges,
                  ),
                ),
                //#endregion Save changes Button
              ],
            ),
          ),
        );
      },
    );
  }
}

class _MeridiemWidget extends StatelessWidget {
  final String meridiem;
  final bool isSelected;
  final GestureTapCallback? onTap;

  const _MeridiemWidget({Key? key, required this.meridiem, required this.isSelected, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? kBlueColor : Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(3)),
        ),
        child: Text(
          meridiem,
          textAlign: TextAlign.center,
          style: textStyle14Normal.copyWith(color: isSelected ? Colors.white : kBlackShadeColor),
        ),
      ),
    );
  }
}
