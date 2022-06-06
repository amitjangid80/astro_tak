// Created By Amit Jangid on 05/06/22

import 'dart:convert';

import 'package:astro_tak/app/core/utils/constants/http_constants.dart';
import 'package:astro_tak/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:astro_tak/app/rest/api_client/api_response.dart';
import 'package:astro_tak/app/core/utils/constants/app_constants.dart';

class ApiClient extends http.BaseClient implements _IHttp {
  static const String _tag = 'ApiClient';
  final http.Client _client = http.Client();

  late final String _baseUrl;

  ApiClient._();

  static ApiClient? _instance;

  static ApiClient get to => _instance ??= ApiClient._();

  set baseUrl(String value) => _baseUrl = value;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll({
      kAccept: kApplicationJson,
      kContentType: kApplicationJson,
      kAuthorization: "$kBearer $kAuthToken",
    });

    return _client.send(request);
  }

  @override
  Future<ApiResponse> getApi({required String api}) async {
    try {
      final bool checkConnectivity = await _checkConnectivity();

      if (!checkConnectivity) {
        return ApiResponse(isSuccess: false, responseBody: kMsgInternetNotAvailable);
      }

      final headers = {
        kAccept: kApplicationJson,
        kContentType: kApplicationJson,
        kAuthorization: "$kBearer $kAuthToken",
      };

      debugPrint('getApi: api is: $api');
      final response = await _client.get(_parseApi(api), headers: headers);

      debugPrint('getApi: response status code is: ${response.statusCode}');
      debugPrint('getApi: response body is: ${response.body}');

      if (response.statusCode == 200) {
        return ApiResponse(isSuccess: true, responseBody: _parseFromJson(response.body));
      }

      return ApiResponse(isSuccess: false, responseBody: kMsgUnableToConnect);
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while making get api call',
      );

      return ApiResponse(isSuccess: false, responseBody: kMsgUnableToConnect);
    }
  }

  @override
  Future<ApiResponse> postApi({required String path, dynamic body}) async {
    try {
      final bool checkConnectivity = await _checkConnectivity();

      if (!checkConnectivity) {
        return ApiResponse(isSuccess: false, responseBody: kMsgInternetNotAvailable);
      }

      final headers = {
        kAccept: kApplicationJson,
        kContentType: kApplicationJson,
        kAuthorization: "$kBearer $kAuthToken",
      };

      final api = _parseApi(path);
      final requestBody = body != null ? _parseToJson(body) : null;

      debugPrint('postApi: api is: $api');
      debugPrint('postApi: request body is: $requestBody');
      final response = await _client.post(api, headers: headers, body: requestBody);

      debugPrint('postApi: response status code is: ${response.statusCode}');
      debugPrint('postApi: response body is: ${response.body}');

      if (response.statusCode == 200) {
        return ApiResponse(isSuccess: true, responseBody: _parseFromJson(response.body));
      }

      return ApiResponse(isSuccess: false, responseBody: kMsgUnableToConnect);
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while making post api call',
      );

      return ApiResponse(isSuccess: false, responseBody: kMsgUnableToConnect);
    }
  }

  Uri _parseApi(final api) => Uri.parse("$_baseUrl$api");

  String _parseToJson(final body) => jsonEncode(body);

  dynamic _parseFromJson(final body) => jsonDecode(body);

  Future<bool> _checkConnectivity() async {
    final ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }

    return true;
  }
}

abstract class _IHttp {
  Future<ApiResponse> getApi({required String api});

  Future<ApiResponse> postApi({required String path, required dynamic body});
}
