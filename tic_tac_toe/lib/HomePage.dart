import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool isCross = true;
  String message;
  List<String> gameState;

  AssetImage cross = AssetImage('fltictactoe/images/cross.png');
  AssetImage circle = AssetImage('fltictactoe/images/circle.png');
  AssetImage edit = AssetImage('fltictactoe/images/edit.png');

  @override
  void initState() {
    super.initState();
    setState(() {
     this.gameState = ['empty', 'empty', 'empty', 'empty', 'empty', 'empty', 'empty', 'empty', 'empty'];
     this.message = '';
    });
  }

  playGame(int index) {
    if(this.gameState[index] == 'empty') {
      setState(() {
       if(this.isCross) {
         this.gameState[index] = 'Cross';
       } else {
         this.gameState[index] = 'Circle';
       }
       this.isCross = !this.isCross;
       this.checkWin();
      });
    }
  }

  void resetGame() {
    Future.delayed(const Duration(seconds : 3), () {
      setState(() {
        this.gameState = ['empty', 'empty', 'empty', 'empty', 'empty', 'empty', 'empty', 'empty', 'empty',];
        this.message = ''; 
      });
    });
  }

  void resetGame1() {
    setState(() {
      this.gameState = ['empty', 'empty', 'empty', 'empty', 'empty', 'empty', 'empty', 'empty', 'empty',];
      this.message = ''; 
    });
  }

  AssetImage getImage(String value) {
    switch (value) {
      case ('empty'):
        return edit;        
        break;
      case ('Cross'):
        return cross;        
        break;
      case ('Circle'):
        return circle;        
        break;
    }
  }

  void checkWin() {
    if(gameState[0] != 'empty' && 
      (gameState[0] == gameState[1]) &&
      (gameState[2] == gameState[1])
      ) {
        setState(() {
        this.message = '${this.gameState[0]} wins.';
        this.resetGame();
      });
    } else if(gameState[3] != 'empty' && 
      (gameState[3] == gameState[4]) &&
      (gameState[5] == gameState[4])) {
        setState(() {
        this.message = '${this.gameState[3]} wins.'; 
        this.resetGame();
      });
    } else if(gameState[6] != 'empty' && 
      (gameState[6] == gameState[7]) &&
      (gameState[8] == gameState[6])) {
        setState(() {
        this.message = '${this.gameState[6]} wins.'; 
        this.resetGame();
      });
    } else if(gameState[0] != 'empty' && 
      (gameState[0] == gameState[3]) &&
      (gameState[3] == gameState[6])) {
        setState(() {
        this.message = '${this.gameState[0]} wins.'; 
        this.resetGame();
      });
    } else if(gameState[1] != 'empty' && 
      (gameState[1] == gameState[4]) &&
      (gameState[4] == gameState[7])) {
        setState(() {
        this.message = '${this.gameState[1]} wins.';
        this.resetGame(); 
      });
    } else if(gameState[2] != 'empty' && 
      (gameState[2] == gameState[5]) &&
      (gameState[5] == gameState[8])) {
        setState(() {
        this.message = '${this.gameState[2]} wins.';
        this.resetGame(); 
      });
    } else if(gameState[0] != 'empty' && 
      (gameState[0] == gameState[4]) &&
      (gameState[4] == gameState[8])) {
        setState(() {
        this.message = '${this.gameState[0]} wins.';
        this.resetGame(); 
      });
    } else if(gameState[2] != 'empty' && 
      (gameState[2] == gameState[4]) &&
      (gameState[4] == gameState[6])) {
        setState(() {
        this.message = '${this.gameState[2]} wins.';
        this.resetGame(); 
      });
    } else if(!gameState.contains('empty')) {
      setState(() {
       this.message = 'Game Drawn';
       this.resetGame();
      });
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(20.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: this.gameState.length, // or simply 9
              itemBuilder: (context, i) => SizedBox(
                height: 100.0,
                width: 100.0,
                child: MaterialButton(
                  onPressed: () =>
                    this.playGame(i),
                  child: Image(
                    image: getImage(this.gameState[i]),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Text(this.message, style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            )),
          ),
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0)
            ),
            color: Colors.green,
            minWidth: 300.0,
            height: 50.0,
            child: Text('Reset Game', style: TextStyle(
              color: Colors.white,
              fontSize: 20.0 ),
            ),
            onPressed: () {
              this.resetGame1();
            },
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Text('Built By Abe10', style : TextStyle(
              fontSize : 18.0,
              color: Colors.black45
              )
            ),
          ),
        ],
      )
    );
  }
}