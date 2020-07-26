import 'package:flutter/material.dart';
import '../reusable/Wcards.dart';
import '../model/chat.dart';

class Status extends StatefulWidget {
  @override
  _StatusState createState() => _StatusState();
}

class _StatusState extends State<Status> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Wcards('My Status', 
        "https://images.pexels.com/photos/1149022/pexels-photo-1149022.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500"
        , 'Tap To Add Status'),
        Divider(),
        Heading('Unseen updates'),
        Wcards(messageData[3].name, messageData[3].imageUrl, messageData[3].time),
        Wcards(messageData[5].name, messageData[5].imageUrl, messageData[5].time),
        Divider(),
        Heading('Vieweed updates'),
        Wcards(messageData[1].name, messageData[1].imageUrl, messageData[1].time),
        Wcards(messageData[6].name, messageData[6].imageUrl, messageData[6].time),
      ],
    );
  }
}

class Heading extends StatelessWidget {

  final String heading;
  
  Heading(this.heading);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: 
        Padding(
          padding: EdgeInsets.only(left: 5, top: 5),
          child: Text(heading, style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey
          ), ),
        ),
    );
  }
}