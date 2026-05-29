import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:of27_llm_based_chat_bot_app/data/services/chat_api_service.dart';
import 'package:of27_llm_based_chat_bot_app/presentation/providers/chat_provider.dart';
import 'package:of27_llm_based_chat_bot_app/presentation/providers/image_gen_provider.dart';
import 'package:of27_llm_based_chat_bot_app/presentation/screens/chat_screen.dart';
import 'package:of27_llm_based_chat_bot_app/presentation/screens/main_screen.dart';
import 'package:of27_llm_based_chat_bot_app/presentation/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => ChatProvider(chatApiService: ChatApiService())),
            ChangeNotifierProvider(create: (_)=> ImageGenProvider())
          ],
          child: const MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of our application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Bot',
      theme: ThemeData(

        colorSchemeSeed: Colors.deepPurple,

      ),

      initialRoute: SplashScreen.routeName,

      routes: {

        SplashScreen.routeName : (context) => const SplashScreen(),

        ChatScreen.routeName : (context) => const ChatScreen(),

        MainScreen.routeName : (context) => const MainScreen()

      },

    );
  }
}
