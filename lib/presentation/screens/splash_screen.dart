import 'package:flutter/material.dart';
import 'package:of27_llm_based_chat_bot_app/core/constants/app_strings.dart';
import 'package:of27_llm_based_chat_bot_app/presentation/screens/chat_screen.dart';

import '../../core/constants/app_colors.dart';

class SplashScreen extends StatefulWidget {

  static const String routeName = '/splash';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {

    super.initState();

    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 3));

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut)
    );

    _animationController.forward();

    _moveToNextScreen();

  }

  Future<void> _moveToNextScreen() async {

    await Future.delayed(const Duration(seconds: 3), () {
      if(!mounted) return;
      Navigator.pushReplacementNamed(context, ChatScreen.routeName);
    });

  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: AppColors.primary,

      body: FadeTransition(

        opacity: _fadeAnimation,

        child: Center(
          child: Column(

            mainAxisAlignment: .center,

            children: [

              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(

                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle

                ),
                child: Icon(Icons.smart_toy_outlined, size: 56, color: Colors.white,),
              ),
              Text(AppStrings.appName,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: .bold,
                    color: Colors.white
                  )
              )

            ],

          ),
        ),
      ),

    );

  }
}