import 'package:chatgpt_chat_app_ai/provider/chat_provider.dart';
import 'package:chatgpt_chat_app_ai/screen/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ChatProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'CHAT GPT-3 APP',
        theme: ThemeData(
          // This is the theme of your application.
          primarySwatch: Colors.blue,
        ),
        routes: {
          Homepage.routeName: (context) => const Homepage(),
        },
        initialRoute: Homepage.routeName,
      ),
    );
  }
}
