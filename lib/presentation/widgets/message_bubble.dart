import 'package:flutter/material.dart';
import 'package:of27_llm_based_chat_bot_app/domain/entities/message_entity.dart';

import '../../core/constants/app_colors.dart';

class MessageBubble extends StatelessWidget {

  final MessageEntity messageEntity;

  const MessageBubble({super.key, required this.messageEntity});

  @override
  Widget build(BuildContext context) {

    final isUser = messageEntity.isUser;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(

        margin: EdgeInsets.only(
          left: isUser ? 64 : 16,
          right: isUser ? 16 : 64,
          bottom: 8
        ),

        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration:  BoxDecoration(
          color: isUser ? AppColors.userBubble : AppColors.botBubble,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(isUser ? 20 : 4),
            bottomRight: Radius.circular(isUser ? 4 : 20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),

        child: Column(

          crossAxisAlignment: .end,
          mainAxisSize: .min,

          children: [

            Text(
              messageEntity.text,
              style: TextStyle(
                color: isUser ? AppColors.userText : AppColors.botText,
                fontSize: 15,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _formatTime(messageEntity.time),
              style: const TextStyle(color: AppColors.timestamp, fontSize: 11),
            )

          ],

        ),

      )
    );

  }

  String _formatTime(DateTime time){

    final hour = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');
    return '$hour:$minutes}';

  }

}