// Created By Amit Jangid on 05/06/22

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:astro_tak/app/models/ask_question/category.dart';
import 'package:astro_tak/app/core/utils/constants/app_constants.dart';
import 'package:astro_tak/app/modules/ask_question/rest/ask_question_services.dart';
import 'package:astro_tak/app/modules/widgets/loading/controllers/loading_controller.dart';

class AskQuestionController extends GetxController {
  int currentIndex = 2;

  Category? mSelectedCategory;
  List<Category> categoriesList = [];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController suggestionController = TextEditingController();

  @override
  void onReady() {
    super.onReady();

    // calling get categories list method
    getCategoriesList();
  }

  getCategoriesList() async {
    LoadingController.to.isLoading = true;

    // calling get categories list api method
    categoriesList = await AskQuestionServices.to.getCategoriesListApi();
    mSelectedCategory = categoriesList[0];
    update([kAskAQuestion]);

    LoadingController.to.isLoading = false;
  }

  onBottomMenuSelected(int selectedIndex) {
    debugPrint('selected index is: $selectedIndex');

    currentIndex = selectedIndex;
    update([kAskAQuestion]);
  }

  onCategoryChanged(Category? selectedCategory) {
    if (selectedCategory != null) {
      suggestionController.text = '';
      mSelectedCategory = selectedCategory;
      update([kAskAQuestion]);
    }
  }

  onSuggestionSelected(String selectedSuggestion) {
    suggestionController.text = selectedSuggestion;
    update([kAskAQuestion]);
  }

  String? validateQuestion(String? question) {
    if (question == null) {
      return kMsgEnterQuestion;
    }

    if (question.isEmpty) {
      return kMsgEnterQuestion;
    }

    return null;
  }

  Future<void> apiFunction() async {
    final Timer timer = Timer(const Duration(minutes: 1), () {
      // here we add the code to make the api call...
      // this will call the api every one minute.
    });
  }
}
