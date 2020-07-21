import 'package:flutter/material.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  AssetImage one = AssetImage('flimages/images/one.png');
  AssetImage two = AssetImage('flimages/images/two.png');
  AssetImage three = AssetImage('flimages/images/three.png');
  AssetImage four = AssetImage('flimages/images/four.png');
  AssetImage five = AssetImage('flimages/images/five.png');
  AssetImage six = AssetImage('flimages/images/six.png');

  AssetImage diceImage, diceImage2;

  @override
  void initState() {
    super.initState();
    setState(() {
     diceImage = one; 
     diceImage2 = one;
    });
  }

  void rollDice() {
    int rnd = Random().nextInt(6) + 1;
    int rnd2 = Random().nextInt(6) + 1;

    AssetImage newImage, newImage2;

    switch (rnd) {
      case 1:
        newImage = one;        
        break;
      case 2:
        newImage = two;        
        break;
      case 3:
        newImage = three;        
        break;
      case 4:
        newImage = four;        
        break;
      case 5:
        newImage = five;        
        break;
      case 6:
        newImage = six;        
        break;        
    }

    switch (rnd2) {
      case 1:
        newImage2 = one;        
        break;
      case 2:
        newImage2 = two;        
        break;
      case 3:
        newImage2 = three;        
        break;
      case 4:
        newImage2 = four;        
        break;
      case 5:
        newImage2 = five;        
        break;
      case 6:
        newImage2 = six;        
        break;        
    }

    setState(() {
     diceImage = newImage; 
     diceImage2 = newImage2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dice Roller'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image(
                    image: diceImage,
                    width: 100.0,
                    height: 100.0,
                  ),
                  Image(
                    image: diceImage2,
                    width: 100.0,
                    height: 100.0,
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 100.0),
                child: RaisedButton(
                  shape : RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)
                  ),
                  onPressed: rollDice,
                  color: Color(0xFFEEC213),
                  padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
                  child: Text('Roll The Dices', style: TextStyle(fontSize: 20.0),),   
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}