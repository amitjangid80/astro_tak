// Created By Amit Jangid on 06/06/22

import 'package:astro_tak/app/core/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:astro_tak/app/models/family/family.dart';
import 'package:astro_tak/app/rest/api_client/api_client.dart';
import 'package:astro_tak/app/models/family/place_of_birth.dart';
import 'package:astro_tak/app/rest/api_client/api_response.dart';
import 'package:astro_tak/app/core/utils/constants/http_constants.dart';

class FriendsFamilyServices {
  static FriendsFamilyServices get to => Get.find<FriendsFamilyServices>();

  Future<List<Family>> getFamiliesListApi() async {
    // calling get api method
    final ApiResponse apiResponse = await ApiClient.to.getApi(api: kApiRelativeList);

    if (apiResponse.isSuccess) {
      final responseBody = apiResponse.responseBody[kJsonData][kJsonAllRelatives];

      if (responseBody.isNotEmpty) {
        final List<Family> familyList = responseBody.map<Family>((familyJson) => Family.fromJson(familyJson)).toList();

        return familyList;
      }
    }

    return [];
  }

  Future<List<PlaceOfBirth>> getLocationApi({required String inputPlace}) async {
    final queryParam = "$kJsonInputPlace=$inputPlace";

    // calling get api method
    final ApiResponse apiResponse = await ApiClient.to.getApi(api: '$kApiLocation?$queryParam');

    if (apiResponse.isSuccess) {
      final responseBody = apiResponse.responseBody[kJsonData];

      if (responseBody.isNotEmpty) {
        final List<PlaceOfBirth> placeOfBirthList =
            responseBody.map<PlaceOfBirth>((placeOfBirthJson) => PlaceOfBirth.fromJson(placeOfBirthJson)).toList();

        return placeOfBirthList;
      }
    }

    return [];
  }

  Future<String> addRelativeApi({required Family family}) async {
    // calling post api method
    final ApiResponse apiResponse = await ApiClient.to.postApi(path: kApiAddRelative, body: family.toAddJson());

    if (apiResponse.isSuccess && apiResponse.responseBody.isNotEmpty) {
      return apiResponse.responseBody[kJsonMessage];
    }

    return kMsgUnableToConnect;
  }

  Future<String> updateRelativeApi({required Family family}) async {
    final queryParam = family.uuid;

    // calling post api method
    final ApiResponse apiResponse = await ApiClient.to.postApi(
      body: family.toUpdateJson(),
      path: '$kApiUpdateRelative$queryParam',
    );

    if (apiResponse.isSuccess && apiResponse.responseBody.isNotEmpty) {
      return apiResponse.responseBody[kJsonMessage];
    }

    return kMsgUnableToConnect;
  }

  Future<String> deleteRelativeApi({required String uuid}) async {
    // calling post api method
    final ApiResponse apiResponse = await ApiClient.to.postApi(path: '$kApiDeleteRelative$uuid');

    if (apiResponse.isSuccess && apiResponse.responseBody.isNotEmpty) {
      return apiResponse.responseBody[kJsonMessage];
    }

    return kMsgUnableToConnect;
  }
}
