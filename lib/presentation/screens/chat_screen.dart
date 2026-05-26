import 'package:flutter/material.dart';
import 'package:of27_llm_based_chat_bot_app/core/constants/app_strings.dart';
import 'package:of27_llm_based_chat_bot_app/presentation/providers/chat_provider.dart';
import 'package:of27_llm_based_chat_bot_app/presentation/widgets/chat_input_field.dart';
import 'package:of27_llm_based_chat_bot_app/presentation/widgets/empty_chat.dart';
import 'package:of27_llm_based_chat_bot_app/presentation/widgets/message_bubble.dart';
import 'package:of27_llm_based_chat_bot_app/presentation/widgets/typing_indicator.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';

class ChatScreen extends StatefulWidget {

  static const String routeName = '/chat-screen';

  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        backgroundColor: AppColors.primary,

        title: Row(

          children: [

            Container(
              height: 36,
              width: 36,
              decoration: const BoxDecoration(color: Colors.white, shape: .circle),
              child: Icon(Icons.smart_toy_outlined, size: 22),
            ),

            const SizedBox(width: 10),

            Text(
              AppStrings.appName,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: .w500,
                fontSize: 14
              ),
            ),

            const SizedBox(width: 10),

          ],

        ),

        actions: [
          Container(
            height: 8,
            width: 8,
            decoration: const BoxDecoration( color: Colors.greenAccent, shape: .circle),
          ),

          const SizedBox(width: 6,),

          Text(
            'Online',
            style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: .w500
            ),
          ),
          const SizedBox(width: 20)
        ],

      ),

      body: Padding(
        padding: const EdgeInsets.all(8),

        child: Consumer<ChatProvider>(
            builder: (BuildContext context, provider, child) {

              return Column(

                children: [

                  Expanded(
                      child: provider.messages.isEmpty && !provider.isLoading
                          ? const Center(child: EmptyChat())
                          : ListView.builder(
                            itemCount: provider.messages.length + (provider.isLoading ? 1 : 0),
                            itemBuilder: (BuildContext context, int index) {

                              if(index == provider.messages.length) return const TypingIndicator();

                              return MessageBubble(messageEntity: provider.messages[index]);

                          }
                      )
                  ),

                  ChatInputField(
                      onSend: (text) async {

                        final isSuccess = await provider.sendMessage(text);

                        if(!isSuccess){
                          throw Exception('${provider.errorMessage}');
                        }

                      },
                      isLoading: provider.isLoading
                  )

                ],

              );

            }
        ),
      ),

    );

  }
}
