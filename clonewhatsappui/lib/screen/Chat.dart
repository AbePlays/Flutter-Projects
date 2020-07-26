import 'package:flutter/material.dart';
import '../model/chat.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messageData.length,
      itemBuilder: (context, i) {
        return Column(
          children: <Widget>[
            Divider(height: 20,),
            ListTile(
              leading: CircleAvatar(
                maxRadius: 25,
                backgroundImage: NetworkImage(messageData[i].imageUrl),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(messageData[i].name, style: TextStyle(
                    fontWeight: FontWeight.bold
                  ), ),
                  Text(messageData[i].time, style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12
                  ), )
                ],
              ),
              subtitle: Container(
                padding: EdgeInsets.fromLTRB(0, 5, 35, 0),
                child: Text(messageData[i].message, style: TextStyle(
                  fontSize: 15
                ), )
              ),
              onTap: () {},
            )
          ],
        );
      },
    );
  }
}