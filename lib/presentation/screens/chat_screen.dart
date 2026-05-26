import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../providers/chat_provider.dart';
import '../widgets/chat_input_field.dart';
import '../widgets/empty_chat.dart';
import '../widgets/message_bubble.dart';
import '../widgets/typing_indicator.dart';

class ChatScreen extends StatefulWidget {

  static const String routeName = '/chat-screen';

  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  late final ScrollController _scrollController;
  //bool _showScrollButton = false;

  final ValueNotifier<bool> _showScrollButton = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.hasClients) {
      final isAtBottom = _scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200;
      if (isAtBottom && _showScrollButton.value) {

        _showScrollButton.value = false;

      } else if (!isAtBottom && !_showScrollButton.value) {

        _showScrollButton.value = true;

      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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

            const Text(
              AppStrings.appName,
              style: TextStyle(
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

          const Text(
            'Online',
            style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: .w500
            ),
          ),
          const SizedBox(width: 20)
        ],

      ),

      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Consumer<ChatProvider>(
                builder: (BuildContext context, provider, child) {
              return Column(
                children: [
                  Expanded(
                      child: provider.messages.isEmpty && !provider.isLoading
                          ? const Center(child: EmptyChat())
                          : ListView.builder(
                              controller: _scrollController,
                              itemCount: provider.messages.length +
                                  (provider.isLoading ? 1 : 0),
                              itemBuilder: (BuildContext context, int index) {
                                if (index == provider.messages.length) {
                                  return const TypingIndicator();
                                }

                                return MessageBubble(
                                    messageEntity: provider.messages[index]);
                              })),
                  ChatInputField(
                      onSend: (text) async {
                        final isSuccess = await provider.sendMessage(text);

                        if (!isSuccess) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(provider.errorMessage ??
                                      'Failed to send message')),
                            );
                          }
                        } else {
                          _scrollToBottom();
                        }
                      },
                      isLoading: provider.isLoading
                  )
                ],
              );
            }),
          ),
          // if (_showScrollButton)
          //   Align(
          //     alignment: Alignment(0.0, 0.8),
          //     child: FloatingActionButton.small(
          //       onPressed: _scrollToBottom,
          //       backgroundColor: AppColors.primary,
          //       child: const Icon(Icons.arrow_downward, color: Colors.white),
          //     ),
          //   ),
          ValueListenableBuilder(
              valueListenable: _showScrollButton,
              builder: (BuildContext context, value, child){

                if (value) {
                  return Align(
                    alignment: Alignment(0.0, 0.8),
                    child: FloatingActionButton.small(
                      onPressed: _scrollToBottom,
                      backgroundColor: AppColors.primary,
                      child: const Icon(Icons.arrow_downward, color: Colors.white),
                    ),
                  );
                }

                return const SizedBox.shrink();

              }
          )
        ],
      ),

    );

  }

  void _scrollToBottom() {

    if(_scrollController.hasClients){
      _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut
      );
    }

  }

}
