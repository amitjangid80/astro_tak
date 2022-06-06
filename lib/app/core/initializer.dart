// Created By Amit Jangid on 05/06/22

import 'package:flutter/material.dart';
import 'package:astro_tak/app/rest/api_client/api_client.dart';
import 'package:astro_tak/app/core/utils/constants/http_constants.dart';

class Initializer {
  Initializer._();

  static Initializer? _instance;

  static Initializer get to => _instance ??= Initializer._();

  void onInit() {
    WidgetsFlutterBinding.ensureInitialized();

    ApiClient.to.baseUrl = kBaseUrl;
  }
}
