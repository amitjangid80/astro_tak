// Created By Amit Jangid on 06/06/22

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:astro_tak/app/models/family/family.dart';
import 'package:astro_tak/app/models/family/relation.dart';
import 'package:astro_tak/app/models/family/birth_details.dart';
import 'package:astro_tak/app/models/family/place_of_birth.dart';
import 'package:astro_tak/app/core/utils/constants/app_constants.dart';
import 'package:astro_tak/app/modules/friends_family/rest/friends_family_services.dart';
import 'package:astro_tak/app/modules/widgets/loading/controllers/loading_controller.dart';
import 'package:astro_tak/app/modules/friends_family/controllers/friends_family_controller.dart';

class AddProfileController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController dobDayController = TextEditingController();
  final TextEditingController dobYearController = TextEditingController();
  final TextEditingController tobHourController = TextEditingController();
  final TextEditingController dobMonthController = TextEditingController();
  final TextEditingController tobMinuteController = TextEditingController();
  final TextEditingController placeOfBirthController = TextEditingController();

  String? mSelectedGender;
  bool isAmSelected = true;
  final _searchPlaceOfBirth = ''.obs;

  Family? mFamilyToEdit;
  Relation? mSelectedRelation;
  PlaceOfBirth? mSelectedPlaceOfBirth;

  List<PlaceOfBirth> placeOfBirthList = [];
  final List<String> meridiemList = [kAM, kPM];

  String get searchPlaceOfBirth => _searchPlaceOfBirth.value;

  set searchPlaceOfBirth(searchPlaceOfBirth) => _searchPlaceOfBirth.value = searchPlaceOfBirth;

  @override
  void onInit() {
    super.onInit();

    mFamilyToEdit = FriendsFamilyController.to.mFamilyEdit;

    // calling plot family details
    plotFamilyDetails();

    debounce(_searchPlaceOfBirth, (_) => getPlacesByInput());
  }

  plotFamilyDetails() {
    if (mFamilyToEdit != null) {
      mSelectedGender = mFamilyToEdit!.gender;
      mSelectedPlaceOfBirth = mFamilyToEdit!.birthPlace;
      mSelectedRelation = relationList.where((relation) => relation.relationId == mFamilyToEdit!.relationId).first;

      nameController.text = mFamilyToEdit!.fullName;
      mSelectedPlaceOfBirth = mFamilyToEdit!.birthPlace;
      placeOfBirthController.text = mFamilyToEdit!.birthPlace.placeName;
      dobDayController.text = mFamilyToEdit!.birthDetails.dobDay.toString();
      dobYearController.text = mFamilyToEdit!.birthDetails.dobYear.toString();
      tobHourController.text = mFamilyToEdit!.birthDetails.tobHour.toString();
      dobMonthController.text = mFamilyToEdit!.birthDetails.dobMonth.toString();
      tobMinuteController.text = mFamilyToEdit!.birthDetails.tobMinute.toString();
      isAmSelected = mFamilyToEdit!.birthDetails.meridiem.toLowerCase() == kAM.toLowerCase();
    }
  }

  onAmPmSelected() {
    isAmSelected = !isAmSelected;
    update([kAddNewProfile]);
  }

  onGenderSelected(String? selectedGender) {
    mSelectedGender = selectedGender;
    update([kAddNewProfile]);
  }

  onRelationSelected(Relation? selectedRelation) {
    mSelectedRelation = selectedRelation;
    update([kAddNewProfile]);
  }

  onPlaceOfBirthSelected(PlaceOfBirth? selectedPlaceOfBirth) {
    mSelectedPlaceOfBirth = selectedPlaceOfBirth;
    placeOfBirthController.text = selectedPlaceOfBirth!.placeName;
    placeOfBirthList = [];
    update([kAddNewProfile]);
  }

  String? validateName(String? name) {
    if (name == null) {
      return kMsgEnterValidName;
    }

    if (name.isEmpty) {
      return kMsgEnterValidName;
    }

    return null;
  }

  String? validateDD(String? dd) {
    if (dd == null) {
      return kMsgInvalidDD;
    }

    if (dd.isEmpty) {
      return kMsgInvalidDD;
    }

    return null;
  }

  String? validateMM(String? mm) {
    if (mm == null) {
      return kMsgInvalidMM;
    }

    if (mm.isEmpty) {
      return kMsgInvalidMM;
    }

    return null;
  }

  String? validateYYYY(String? yyyy) {
    if (yyyy == null) {
      return kMsgInvalidYY;
    }

    if (yyyy.isEmpty) {
      return kMsgInvalidYY;
    }

    return null;
  }

  String? validateHH(String? hh) {
    if (hh == null) {
      return kMsgInvalidHH;
    }

    if (hh.isEmpty) {
      return kMsgInvalidHH;
    }

    return null;
  }

  String? validatePlaceOfBirth(String? selectedPlaceOfBirth) {
    if (selectedPlaceOfBirth == null) {
      return kMsgSelectCity;
    }

    if (selectedPlaceOfBirth.isEmpty) {
      return kMsgSelectCity;
    }

    return null;
  }

  String? validateGender(String? selectedGender) {
    if (selectedGender == null) {
      return kMsgInvalidGender;
    }

    if (selectedGender.isEmpty) {
      return kMsgInvalidGender;
    }

    return null;
  }

  String? validateRelation(Relation? relation) {
    if (relation == null) {
      return kMsgInvalidRelation;
    }

    return null;
  }

  clearAllFields() {
    nameController.text = '';
    dobDayController.text = '';
    dobYearController.text = '';
    tobHourController.text = '';
    dobMonthController.text = '';
    tobMinuteController.text = '';
    placeOfBirthController.text = '';

    isAmSelected = true;
    mFamilyToEdit = null;
    mSelectedGender = null;
    mSelectedRelation = null;
    mSelectedPlaceOfBirth = null;

    update([kAddNewProfile]);
  }

  getPlacesByInput() async {
    if (searchPlaceOfBirth.isNotEmpty) {
      LoadingController.to.isLoading = true;

      // calling get location api method
      placeOfBirthList = await FriendsFamilyServices.to.getLocationApi(inputPlace: searchPlaceOfBirth);
      update([kAddNewProfile]);

      LoadingController.to.isLoading = false;
    } else {
      placeOfBirthList = [];
      update([kAddNewProfile]);
    }
  }

  saveChanges() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      LoadingController.to.isLoading = true;

      final fullName = nameController.value.text.trim().split(' ');
      final firstName = fullName[0];
      final middleName = fullName.length == 3 ? fullName[1] : '';

      final lastName = fullName.length == 3
          ? fullName[2]
          : fullName.length == 2
              ? fullName[1]
              : '';

      final Family family = Family(
        uuid: mFamilyToEdit?.uuid ?? '',
        firstName: firstName /*mFamilyToEdit?.firstName ?? ''*/,
        middleName: middleName /*mFamilyToEdit?.middleName ?? ''*/,
        lastName: lastName /*mFamilyToEdit?.lastName ?? ''*/,
        fullName: nameController.value.text.trim(),
        dateTimeOfBirth: '${tobHourController.value.text.trim()}:${tobMinuteController.value.text.trim()}',
        gender: mSelectedGender!,
        relationId: mSelectedRelation!.relationId,
        relation: mSelectedRelation!.relation,
        birthPlace: PlaceOfBirth(placeId: mSelectedPlaceOfBirth!.placeId, placeName: mSelectedPlaceOfBirth!.placeName),
        birthDetails: BirthDetails(
          dobDay: int.parse(dobDayController.value.text.trim()),
          dobMonth: int.parse(dobMonthController.value.text.trim()),
          dobYear: int.parse(dobYearController.value.text.trim()),
          tobHour: int.parse(tobHourController.value.text.trim()),
          tobMinute: int.parse(tobMinuteController.value.text.trim()),
          meridiem: isAmSelected ? kAM : kPM,
        ),
      );

      if (mFamilyToEdit != null) {
        // calling add relative api method
        final result = await FriendsFamilyServices.to.updateRelativeApi(family: family);

        Fluttertoast.showToast(msg: result, gravity: ToastGravity.CENTER, toastLength: Toast.LENGTH_LONG);
      } else {
        // calling add relative api method
        final result = await FriendsFamilyServices.to.addRelativeApi(family: family);

        Fluttertoast.showToast(msg: result, gravity: ToastGravity.CENTER, toastLength: Toast.LENGTH_LONG);
      }

      // calling clear all fields method
      clearAllFields();

      LoadingController.to.isLoading = false;
      FriendsFamilyController.to.onBackPressed();
    }
  }
}
