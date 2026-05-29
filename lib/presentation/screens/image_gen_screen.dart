import 'package:flutter/material.dart';
import 'package:of27_llm_based_chat_bot_app/presentation/providers/image_gen_provider.dart';
import 'package:of27_llm_based_chat_bot_app/presentation/widgets/empty_image_gen.dart';
import 'package:of27_llm_based_chat_bot_app/presentation/widgets/image_message_bubble.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../widgets/chat_app_bar.dart';
import '../widgets/chat_input_field.dart';
import '../widgets/typing_indicator.dart';

class ImageGenScreen extends StatefulWidget {

  const ImageGenScreen({super.key});

  @override
  State<ImageGenScreen> createState() => _ImageGenScreenState();
}

class _ImageGenScreenState extends State<ImageGenScreen> {

  late final ScrollController _scrollController;

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

      appBar: ChatAppBar(),

      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Consumer<ImageGenProvider>(
            builder: (BuildContext context, provider, child) {
              return Column(
                children: [

                  Expanded(
                      child: provider.messages.isEmpty && !provider.isLoading
                          ? const Center(child: EmptyImageGen())
                          : buildListView(provider)
                  ),

                  ChatInputField(
                    onSend: (text) async {

                      final isSuccess = await provider.generateImage(text);

                      if (isSuccess) {
                        _scrollToBottom();
                      } else {
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(provider.errorMessage ?? 'Failed to send message')),
                        );
                      }
                      },
                      isLoading: provider.isLoading,
                      hintText: AppStrings.imageGenInputHint,
                      sendIcon: Icons.auto_awesome,
                  )
                ],
              );
            }),
      ),

    );

  }

  Stack buildListView(ImageGenProvider provider) {
    return Stack(
      children: [
        ListView.builder(
            controller: _scrollController,
            itemCount: provider.messages.length +
                (provider.isLoading ? 1 : 0),

            itemBuilder: (BuildContext context, int index) {

              if (index == provider.messages.length) {
                return const TypingIndicator();
              }

              return ImageMessageBubble(message: provider.messages[index]);

            }),
        ValueListenableBuilder(
            valueListenable: _showScrollButton,
            builder: (BuildContext context, value, child){

              if (!value) {
                return const SizedBox.shrink();
              }

              return Align(
                alignment: Alignment(0.0, 1.0),
                child: FloatingActionButton.small(
                  onPressed: _scrollToBottom,
                  backgroundColor: AppColors.primary,
                  child: const Icon(Icons.arrow_downward, color: Colors.white),
                ),
              );

            }
        )
      ],
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
