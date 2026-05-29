import 'package:flutter/material.dart';
import 'package:of27_llm_based_chat_bot_app/presentation/screens/chat_screen.dart';
import 'package:of27_llm_based_chat_bot_app/presentation/screens/image_gen_screen.dart';

class MainScreen extends StatefulWidget {

  static const String routeName = '/main-screen';

  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int _currentIndex = 0;
  final List<Widget> _screens = const [
    ChatScreen(),
    ImageGenScreen()
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),

      bottomNavigationBar: BottomNavigationBar(

          currentIndex: _currentIndex,

          onTap: navigateBottomBar,

          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline_outlined),
              label: 'Chat'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.image_outlined),
              label: 'Images'
            )
          ],

      ),

    );
  }

  void navigateBottomBar(int index) {

    setState(() {
      _currentIndex = index;
    });

  }

}
