// Created By Amit Jangid on 06/06/22

import 'package:astro_tak/app/core/utils/constants/app_constants.dart';

class Relation {
  int relationId;
  String relation;

  Relation({required this.relationId, required this.relation});
}

List<Relation> relationList = [
  Relation(relationId: 1, relation: kMother),
  Relation(relationId: 2, relation: kFather),
  Relation(relationId: 3, relation: kBrother),
  Relation(relationId: 4, relation: kSister),
  Relation(relationId: 15, relation: kFriend),
  Relation(relationId: 6, relation: kMotherInLaw),
  Relation(relationId: 7, relation: kFatherInLaw),
];
