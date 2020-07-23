import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var dataJson;
  var isPressed = false;
  var url = 'https://api.chucknorris.io/jokes/random';

  Future getData() async {
    var response = await http.get(Uri.encodeFull(url));
    var data = convert.jsonDecode(response.body);
    setState(() {
      dataJson = data;
      isPressed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chuck Norris Jokes',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            !isPressed
                ? SizedBox()
                : Container(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      dataJson['value'],
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
            RaisedButton(
              padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
              color: Colors.orange,
              onPressed: getData,
              child: Text(
                'Get Joke',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            )
          ],
        ),
      ),
    );
  }
}
