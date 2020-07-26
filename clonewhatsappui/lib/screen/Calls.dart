import 'package:flutter/material.dart';
import '../model/calls.dart';

class Calls extends StatefulWidget {
  @override
  _CallsState createState() => _CallsState();
}

class _CallsState extends State<Calls> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: callData.length,
      itemBuilder: (context, i) {
        return Column(
          children: <Widget>[
            Divider(
              height: 20,
            ),
            ListTile(
              leading: CircleAvatar(
                maxRadius: 25,
                backgroundImage: NetworkImage(callData[i].imageUrl),
              ),
              title: Text(callData[i].name, style: TextStyle(
                fontWeight: FontWeight.bold
              ), ),
              subtitle: Container(
                padding: EdgeInsets.only(top: 5),
                child: Text(callData[i].time, style: TextStyle(
                  fontSize: 14
                ), ),),
                trailing: Icon(Icons.call),
                selected: true,
            )
          ],
        );
      },
    );
  }
}