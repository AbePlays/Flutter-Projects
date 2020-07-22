import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'SignupPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Detail',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: SignupPage(),
    );
  }
}