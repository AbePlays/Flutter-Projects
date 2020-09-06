import 'package:flutter/material.dart';

class ScreenTitle extends StatelessWidget {
  final String text;

  const ScreenTitle({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: Duration(seconds: 1),
      tween: Tween<double>(begin: 0, end: 1),
      curve: Curves.easeIn,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Padding(
            padding: EdgeInsets.only(top: value * 20),
            child: child,
          ),
        );
      },
      child: Text(
        text,
        style: TextStyle(fontSize: 36, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
