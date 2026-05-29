import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';

class EmptyImageGen extends StatelessWidget {
  const EmptyImageGen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(

        children: [

          Icon(Icons.image_outlined, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(AppStrings.emptyImageChat, style: TextStyle(fontSize: 16, color: Colors.grey),)

        ],

      ),
    );
  }
}
