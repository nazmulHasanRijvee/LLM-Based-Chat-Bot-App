import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:of27_llm_based_chat_bot_app/core/constants/app_strings.dart';
import 'package:of27_llm_based_chat_bot_app/data/models/message_model.dart';

class ChatApiService {

  Future<ApiResponse> fetchAssistantReply(List<MessageModel> messages) async {

    debugPrint('URL => ${AppStrings.chatUrl}\nLLM Model => ${AppStrings.model}');

    try {

      final Uri uri = Uri.parse(AppStrings.chatUrl);
      
      final Map<String, String> headers = {
        
        'Content-Type' : 'application/json',
        'Authorization' : 'Bearer ${AppStrings.apiKey}'
        
      };
      
      final Map<String, dynamic> data = {
        'model' : AppStrings.model,
        'max_tokens' : 1024,
        'messages' : [
          {
            'role' : 'system',
            'content' : [
              {
                "type" : "text",
                "text" : AppStrings.systemPrompt
              }
            ]
          },
          ...messages.map((message)=> message.toJson())
        ]
      };

      final http.Response response = await http.post(uri, headers: headers, body: jsonEncode(data))
          .timeout(const Duration(seconds: 15));

      final int statusCode = response.statusCode;

      final decodedData = jsonDecode(response.body);

      if(statusCode == 200 || statusCode == 201){

        return ApiResponse(statusCode: statusCode, isSuccess: true, body: decodedData, errorMessage: null);

      } else if (statusCode == 401) {

        return ApiResponse(
            statusCode: statusCode,
            isSuccess: false,
            body: decodedData,
            errorMessage: 'Unauthorized'
        );

      } else {

        return ApiResponse(statusCode: statusCode, isSuccess: false, errorMessage: 'Failed to fetch API', body: decodedData);

      }

    } on TimeoutException catch (e) {

      return ApiResponse(
          statusCode: 000,
          isSuccess: false,
          body: null,
        errorMessage: '${AppStrings.errorTimeout} details: ${e.toString()}'
      );

    } on SocketException catch (e) {

      return ApiResponse(
          statusCode: 000,
          isSuccess: false,
          body: null,
          errorMessage: '${AppStrings.errorNoInternet} details: ${e.toString()}'
      );

    } catch (e) {

      return ApiResponse(statusCode: 000, isSuccess: false, errorMessage: '${AppStrings.errorGeneral} details: ${e.toString()}', body: null);
    }


  }

}

class ApiResponse {

  final dynamic body;
  final int statusCode;
  final bool isSuccess;
  final String? errorMessage;
  ApiResponse({
    this.body,
    required this.statusCode,
    required this.isSuccess,
    this.errorMessage = 'Showing error from ApiResponse'
  });

}