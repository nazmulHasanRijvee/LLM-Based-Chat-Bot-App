import 'package:flutter/material.dart';
import 'package:of27_llm_based_chat_bot_app/core/constants/app_strings.dart';

class EmptyChat extends StatelessWidget {

  const EmptyChat({super.key});

  @override
  Widget build(BuildContext context) {

    return Center(

      child: Column(

        children: [

          Icon(Icons.chat_bubble_outline, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(AppStrings.emptyChat, style: TextStyle(fontSize: 16, color: Colors.grey),)

        ],

      ),

    );

  }
}
