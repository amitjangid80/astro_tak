// Created By Amit Jangid on 06/06/22

import 'package:astro_tak/app/core/utils/constants/http_constants.dart';

class PlaceOfBirth {
  String placeId;
  String placeName;

  PlaceOfBirth({required this.placeId, required this.placeName});

  factory PlaceOfBirth.fromJson(Map<String, dynamic> placeOfBirthJson) => PlaceOfBirth(
        placeId: placeOfBirthJson[kJsonPlaceId],
        placeName: placeOfBirthJson[kJsonPlaceName],
      );

  Map<String, dynamic> toJson() => {kJsonPlaceId: placeId, kJsonPlaceName: placeName};
}
