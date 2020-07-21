import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AssetImage circle = AssetImage('flscratchwin/images/circle.png');
  AssetImage lucky = AssetImage('flscratchwin/images/rupee.png');
  AssetImage unlucky = AssetImage('flscratchwin/images/sadFace.png');

  List<String> itemArray;
  int luckyNumber;

  @override
  void initState() {
    super.initState();
    itemArray = List<String>.generate(25, (index) => 'empty');
    generateRandomNumber();
  }

  void generateRandomNumber() {
    int random = Random().nextInt(25);
    setState(() {
      luckyNumber = random;
    });
  }

  void resetGame() {
    setState(() {
      itemArray = List<String>.filled(25, 'empty');
    });
    generateRandomNumber();
  }

  AssetImage getImage(int index) {
    String currentState = itemArray[index];
    switch (currentState) {
      case 'lucky':
        return lucky;
        break;
      case 'unlucky':
        return unlucky;
        break;
    }
    return circle;
  }

  void playGame(int index) {
    if (luckyNumber == index) {
      setState(() {
        itemArray[index] = 'lucky';
      });
    } else {
      setState(() {
        itemArray[index] = 'unlucky';
      });
    }
  }

  void showAll() {
    setState(() {
      itemArray = List<String>.filled(25, 'unlucky');
      itemArray[luckyNumber] = 'lucky';
    });
  }

  int j = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scratch and Win'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(20.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 1.0,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: itemArray.length,
              itemBuilder: (context, i) => SizedBox(
                width: 50.0,
                height: 50.0,
                child: RaisedButton(
                  onPressed: () {
                    this.playGame(i);
                    ++j;
                    if (j == 5) {
                      Future.delayed(const Duration(seconds: 3), () {
                        this.resetGame();
                        j = 0;
                      });
                    }
                  },
                  child: Image(
                    image: this.getImage(i),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: RaisedButton(
                onPressed: () {
                  this.showAll();
                },
                color: Colors.pink,
                padding: EdgeInsets.all(20.0),
                child: Text('Show All',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ))),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: RaisedButton(
              onPressed: () {
                this.resetGame();
              },
              color: Colors.pink,
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Reset',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 5.0),
            child: Text(
              'Built By Abe10',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
