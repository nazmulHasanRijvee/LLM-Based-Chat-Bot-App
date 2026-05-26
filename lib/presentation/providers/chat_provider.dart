
import 'package:flutter/material.dart';
import 'package:of27_llm_based_chat_bot_app/data/chat_api_service.dart';
import 'package:of27_llm_based_chat_bot_app/data/models/message_model.dart';

class ChatProvider extends ChangeNotifier{

  ChatProvider({ChatApiService? chatApiService}) : chatApiService = chatApiService ?? ChatApiService();

  final ChatApiService chatApiService;
  
  bool _isLoading = false;
  final List<MessageModel> _messages = [];
  String? _errorMessage;
  
  List<MessageModel> get messages => List.unmodifiable(_messages);
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> sendMessage(String text) async {

    bool isSuccess = false;

    if(text.trim().isEmpty) return false;

    _messages.add(MessageModel(role: 'user', text: text, time: DateTime.now()));

    _isLoading = true;

    notifyListeners();

    final debugList = _messages.map((e) => e.text).toList();

    debugPrint('Sending => $debugList');

    final apiResponse = await chatApiService.fetchAssistantReply(_messages);

    if (apiResponse.isSuccess){

      isSuccess = true;

      _errorMessage = null;

      _messages.add(
          MessageModel(
              role: 'assistant',
              text: (apiResponse.body['choices'][0]['message']['content'] as String).trim(),
              time: DateTime.now()
          )
      );

    } else {

      _errorMessage = apiResponse.errorMessage ?? 'Error from chat provider';

    }

    _isLoading = false;

    notifyListeners();

    return isSuccess;

  }

}