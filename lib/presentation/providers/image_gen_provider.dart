import 'package:flutter/material.dart';
import 'package:of27_llm_based_chat_bot_app/domain/entities/image_message.dart';

import '../../data/services/image_gen_api_service.dart';

class ImageGenProvider extends ChangeNotifier {

  ImageGenProvider({ImageGenApiService? imageGenApiService})
      : _imageGenApiService = imageGenApiService ?? ImageGenApiService();

  final ImageGenApiService _imageGenApiService;
  final List<ImageMessage> _messages = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<ImageMessage> get messages => List.unmodifiable(_messages);
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> generateImage(String prompt) async {

    bool isSuccess = false;

    if(prompt.trim().isEmpty) return false;

    _messages.add(
      ImageMessage(role: 'user', prompt: prompt, time: DateTime.now())
    );

    _isLoading = true;
    notifyListeners();
    final apiResponse = await _imageGenApiService.generateImage(prompt);

    if(apiResponse.isSuccess){

      final message = apiResponse.body['choices'][0]['message'];
      final content = message['content'];
      final images = message['images'];

      if (images is !List || images.isEmpty) {
        _errorMessage = 'No Image was returned. Try a more descriptive prompt';
        return false;
      }

      isSuccess = true;
      _errorMessage = null;

    _messages.add(
      ImageMessage(
          role: 'assistant',
          prompt: prompt,
          imageUrl: images[0]['image_url']['url'] as String,
          textContent: content is String && content.trim().isNotEmpty
          ? content.trim()
          : null,
          time: DateTime.now()
      )
    );

    } else {

      _errorMessage = apiResponse.errorMessage ?? 'Showing error from provider';

    }

    _isLoading = false;
    notifyListeners();

    return isSuccess;

  }

}