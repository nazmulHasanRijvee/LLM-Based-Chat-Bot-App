import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget{
  const ChatAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(

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

    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}