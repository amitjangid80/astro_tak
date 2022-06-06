// Created By Amit Jangid on 05/06/22

import 'dart:io';
import 'package:astro_tak/app/models/family/birth_details.dart';
import 'package:device_info_plus/device_info_plus.dart';

Future<String> getDeviceId() async {
  String deviceId;
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    final AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;
    deviceId = androidDeviceInfo.androidId!;
  } else {
    final IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
    deviceId = iosDeviceInfo.identifierForVendor!;
  }

  return deviceId;
}

String getDob(BirthDetails birthDetails) => '${birthDetails.dobDay}-${birthDetails.dobMonth}-${birthDetails.dobYear}';

String getTob(BirthDetails birthDetails) => '${birthDetails.tobHour}:${birthDetails.tobMinute}';
