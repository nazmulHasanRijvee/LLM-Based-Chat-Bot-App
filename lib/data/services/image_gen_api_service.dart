import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:of27_llm_based_chat_bot_app/core/constants/app_strings.dart';
import 'package:of27_llm_based_chat_bot_app/data/services/chat_api_service.dart';
import 'package:http/http.dart' as http;

class ImageGenApiService {

  Future<ApiResponse> generateImage(String prompt) async {

    debugPrint('URL => ${AppStrings.imageGenBaseUrl}\nLLM Model => ${AppStrings.imageGenModel}');

    final Uri uri = Uri.parse(AppStrings.imageGenBaseUrl);

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': AppStrings.imageGenApiKey,
    };

    final data = {
        'model': AppStrings.imageGenModel,
        'max_tokens': 1024,
        'messages': [
          {'role': 'user', 'content': prompt},
        ],
        'modalities': ['image', 'text'],
      };

    try {

      final http.Response response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(data),
      ).timeout(const Duration(seconds: 60));

      final int statusCode = response.statusCode;
      final decodedData = jsonDecode(response.body);

      debugPrint('StatusCode => $statusCode\ndata => $decodedData');

      if (statusCode == 200 || statusCode ==201) {

        return ApiResponse(
            statusCode: statusCode,
            isSuccess: true,
            body: decodedData,
            errorMessage: null
        );

      } else if (statusCode == 401) {

        return ApiResponse(
            statusCode: statusCode,
            isSuccess: false,
            body: decodedData,
            errorMessage: 'Status Code: $statusCode. Unauthorized error'
        );

      } else {

        return ApiResponse(
            statusCode: statusCode,
            isSuccess: false,
            body: decodedData,
            errorMessage: 'Status code: $statusCode. Failed from image api service'
        );

      }

    } on TimeoutException {

      return ApiResponse(
          statusCode: 000, isSuccess: false, body: null, errorMessage: AppStrings.errorTimeout
      );

    } on SocketException {

      return ApiResponse(statusCode: 000, isSuccess: false, body: null, errorMessage: AppStrings.errorNoInternet);

    } catch (e) {

      throw Exception('Exception: $e');

    }
    

  }

}