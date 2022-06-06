// Created By Amit Jangid on 05/06/22

import 'package:astro_tak/app/core/utils/constants/http_constants.dart';

class BirthDetails {
  int dobDay;
  int dobMonth;
  int dobYear;
  int tobHour;
  int tobMinute;
  String meridiem;

  BirthDetails({
    required this.dobDay,
    required this.dobMonth,
    required this.dobYear,
    required this.tobHour,
    required this.tobMinute,
    required this.meridiem,
  });

  factory BirthDetails.fromJson(Map<String, dynamic> birthDetailsJso) => BirthDetails(
        dobDay: birthDetailsJso[kJsonDobDay],
        dobMonth: birthDetailsJso[kJsonDobMonth],
        dobYear: birthDetailsJso[kJsonDobYear],
        tobHour: birthDetailsJso[kJsonTobHour],
        tobMinute: birthDetailsJso[kJsonTobMin],
        meridiem: birthDetailsJso[kJsonMeridiem],
      );

  Map<String, dynamic> toJson() => {
        kJsonDobDay: dobDay,
        kJsonDobMonth: dobMonth,
        kJsonDobYear: dobYear,
        kJsonTobHour: tobHour,
        kJsonTobMin: tobMinute,
        kJsonMeridiem: meridiem,
      };
}
