import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var colors = [
    '6f4a8e',
    '900d0d',
    '006a71',
    '394989',
    '3282b8',
    '6ebfb5',
    'febf63',
    'ffe0f7',
    '5e6f64',
    'ea907a',
  ];

  int index = 0;

  void setIndex() {
    setState(() {
      index = Random().nextInt(9);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Background Changer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Random Background'),
        ),
        body: Center(
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
            color: Colors.white,
            onPressed: setIndex,
            child: Text(
              'Change Background',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
        ),
        backgroundColor: Color(int.parse('FF' + colors[index], radix: 16)),
      ),
    );
  }
}
