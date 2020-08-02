import 'package:flutter/material.dart';
import 'Favorites.dart';
import 'SignIn.dart';
import 'SignUp.dart';
import 'HomePage.dart';
import 'Account.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lyrix',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: SignIn(),
      routes: <String, WidgetBuilder>{
        '/SignIn': (context) => SignIn(),
        '/SignUp': (context) => SignUp(),
        '/HomePage': (context) => HomePage(),
        '/Favorites': (context) => Favorites(),
        '/Account': (context) => Account(),
      },
    );
  }
}
