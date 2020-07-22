import 'package:flutter/material.dart';
import 'numerAudio.dart';
import 'package:audioplayers/audio_cache.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AudioCache audioPlayer = AudioCache();

  List<numberAudio> numberList = [
    numberAudio('one.wav', Colors.red, 'One'),
    numberAudio('two.wav', Colors.teal, 'Two'),
    numberAudio('three.wav', Colors.grey, 'Three'),
    numberAudio('four.wav', Colors.yellow, 'Four'),
    numberAudio('five.wav', Colors.black, 'Five'),
    numberAudio('six.wav', Colors.blue, 'Six'),
    numberAudio('seven.wav', Colors.pink, 'Seven'),
    numberAudio('eight.wav', Colors.green, 'Eight'),
    numberAudio('nine.wav', Colors.purple, 'Nine'),
    numberAudio('ten.wav', Colors.orange, 'Ten'),
  ];

  void play(String uri) {
    audioPlayer.play(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spanish Audio'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.all(20)),
              Text(
                'Learn to speak 1-10 in Spanish',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Padding(padding: EdgeInsets.only(bottom: 20)),
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.all(10.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2.0,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: numberList.length,
                  itemBuilder: (context, i) => SizedBox(
                    height: 50.0,
                    width: 100.0,
                    child: RaisedButton(
                      color: numberList[i].buttonColor,
                      child: Text(
                        numberList[i].buttonText,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        play(numberList[i].audioURI);
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
