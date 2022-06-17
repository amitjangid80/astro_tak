// Created By Amit Jangid 05/06/2022

import 'package:flutter/material.dart';
import 'package:astro_tak/app/core/initializer.dart';
import 'package:astro_tak/app/core/config/routes/routes.dart';
import 'package:astro_tak/app/core/bindings/app_bindings.dart';
import 'package:astro_tak/app/core/config/styles/app_theme.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:astro_tak/app/core/utils/constants/app_constants.dart';
import 'package:astro_tak/app/modules/timer_func/views/timer_widget.dart';

void main() {
  Initializer.to.onInit();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: kAppName,
      theme: themeData(),
      getPages: getPageList,
      initialBinding: AppBindings(),
      // initialRoute: kAskQuestionRoute,
      home: const TimerWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/// handle exception method
/// this method will print exception occurred
handleException({
  required exception,
  required stackTrace,
  required String exceptionClass,
  required String exceptionMsg,
}) async {
  debugPrint('\n');
  debugPrint("========================================START OF EXCEPTION========================================");
  debugPrint("==================================================================================================");
  debugPrint('\n');
  debugPrint('$exceptionClass - $exceptionMsg: \n${exception.toString()}\n$stackTrace');
  debugPrint('\n');
  debugPrint("==================================================================================================");
  debugPrint("=========================================END OF EXCEPTION=========================================");
  debugPrint('\n');
}
