// Created By Amit Jangid on 05/06/22

import 'package:astro_tak/app/modules/screens.dart';
import 'package:astro_tak/app/modules/bindings.dart';
import 'package:get/get_navigation/get_navigation.dart';

const String kAskQuestionRoute = '/askQuestion';
const String kFriendFamilyRoute = '/friendFamily';

List<GetPage> getPageList = [
  GetPage(name: kAskQuestionRoute, binding: AskQuestionBindings(), page: () => const AskQuestionScreen()),
  GetPage(name: kFriendFamilyRoute, binding: FriendsFamilyBindings(), page: () => const FriendsFamilyScreen()),
];
