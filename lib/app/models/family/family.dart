// Created By Amit Jangid on 05/06/22

import 'package:astro_tak/app/models/family/birth_details.dart';
import 'package:astro_tak/app/models/family/place_of_birth.dart';
import 'package:astro_tak/app/core/utils/constants/http_constants.dart';

class Family {
  String uuid;
  String firstName;
  String middleName;
  String lastName;
  String fullName;
  String dateTimeOfBirth;
  String gender;
  int relationId;
  String relation;
  PlaceOfBirth birthPlace;
  BirthDetails birthDetails;

  Family({
    required this.uuid,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.fullName,
    required this.dateTimeOfBirth,
    required this.gender,
    required this.relationId,
    required this.relation,
    required this.birthPlace,
    required this.birthDetails,
  });

  factory Family.fromJson(Map<String, dynamic> familyJson) => Family(
        uuid: familyJson[kJsonUuid],
        firstName: familyJson[kJsonFirstName],
        middleName: familyJson[kJsonMiddleName] ?? '',
        lastName: familyJson[kJsonLastName],
        fullName: familyJson[kJsonFullName],
        dateTimeOfBirth: familyJson[kJsonDateTimeOfBirth],
        gender: familyJson[kJsonGender],
        relationId: familyJson[kJsonRelationId],
        relation: familyJson[kJsonRelation],
        birthPlace: PlaceOfBirth.fromJson(familyJson[kJsonBirthPlace]),
        birthDetails: BirthDetails.fromJson(familyJson[kJsonBirthDetails]),
      );

  Map<String, dynamic> toAddJson() => {
        kJsonFirstName: firstName,
        kJsonLastName: lastName,
        kJsonGender: gender,
        kJsonRelationId: relationId,
        kJsonBirthPlace: birthPlace.toJson(),
        kJsonBirthDetails: birthDetails.toJson(),
      };

  Map<String, dynamic> toUpdateJson() => {
        kJsonUuid: uuid,
        kJsonFirstName: firstName,
        kJsonMiddleName: middleName,
        kJsonLastName: lastName,
        kJsonFullName: fullName,
        kJsonGender: gender,
        kJsonRelation: relation,
        kJsonRelationId: relationId,
        kJsonDateTimeOfBirth: dateTimeOfBirth,
        kJsonBirthPlace: birthPlace.toJson(),
        kJsonBirthDetails: birthDetails.toJson(),
      };
}
