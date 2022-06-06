// Created By Amit Jangid on 05/06/22

import 'package:get/get.dart';
import 'package:astro_tak/app/models/ask_question/category.dart';
import 'package:astro_tak/app/rest/api_client/api_client.dart';
import 'package:astro_tak/app/rest/api_client/api_response.dart';
import 'package:astro_tak/app/core/utils/constants/http_constants.dart';

class AskQuestionServices {
  static AskQuestionServices get to => Get.find<AskQuestionServices>();

  Future<List<Category>> getCategoriesListApi() async {
    // calling get api method
    final ApiResponse apiResponse = await ApiClient.to.getApi(api: kApiCategory);

    if (apiResponse.isSuccess) {
      final responseBody = apiResponse.responseBody[kJsonData];

      if (responseBody.isNotEmpty) {
        final List<Category> categoriesList =
            responseBody.map<Category>((categoryJson) => Category.fromJson(categoryJson)).toList();

        return categoriesList;
      }
    }

    return [];
  }
}
