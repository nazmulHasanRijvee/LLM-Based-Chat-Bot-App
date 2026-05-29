import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppStrings {

  const AppStrings._();

  static const String appName = 'AI Chat Bot';
  static const String inputHint = 'Type a message...';
  static const String imageGenInputHint = 'Describe an image...';
  static const String emptyChat =
      'Start a conversation!\nSend a message below.';

  static const String errorNoInternet =
      'No internet connection. Please check and try again.';
  static const String errorTimeout = 'Request timed out. Please try again.';
  static const String errorGeneral = 'Something went wrong. Please try again.';

  // Chat API
  static final loadKey = dotenv.env['CHAT_API_KEY'] ?? '';
  static String get apiKey =>  'Bearer $loadKey';

  static const String baseUrl = 'https://openrouter.ai/api/v1';
  static const String chatUrl = '$baseUrl/chat/completions';
  static const String model = 'google/gemini-3.1-flash-lite';
  static const String systemPrompt =
      'You are a helpful and friendly AI assistant.';

  // Image Generation API
  static String get imageGenApiKey =>
      'Bearer $loadKey';
  static const String imageGenBaseUrl = 'https://openrouter.ai/api/v1/chat/completions';
  static const String imageGenModel = 'google/gemini-2.5-flash-image';
}