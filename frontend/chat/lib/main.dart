import 'package:chat/Screens/chatscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Chat",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Chatscreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
