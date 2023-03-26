import 'package:aichat/about.dart';
import 'package:aichat/homepage.dart';
import 'package:aichat/imageai/imagepage.dart';
import 'package:aichat/indexpage.dart';
import 'package:aichat/provider/chat_provider.dart';
import 'package:aichat/splashscreen.dart';
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
          create: (_) => chatProvider(),
        )
      ],
      child:
          MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen()),
    );
  }
}
