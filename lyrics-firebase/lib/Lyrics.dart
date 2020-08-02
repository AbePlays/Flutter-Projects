import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class Lyrics extends StatelessWidget {
  final String lyrics, song, artist;
  final db = Firestore.instance;
  final auth = FirebaseAuth.instance;

  Lyrics({Key key, @required this.lyrics, this.song, this.artist})
      : super(key: key);

  Future saveToDatabase() async {
    var user = await auth.currentUser();
    String uid = user.uid;
    var favorites = [];
    try {
      await db.collection('users').document(uid).get().then((value) {
        favorites = value.data['Favorites'];
        var obj = {'song': song, 'artist': artist};
        favorites.add(obj);
        db
            .collection('users')
            .document(uid)
            .updateData({'Favorites': favorites}).then((value) {
          print("Done");
        });
      });
    } catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(song),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), onPressed: saveToDatabase)
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(15, 20, 15, 40),
        child: Text(
          lyrics,
          style: TextStyle(fontSize: 15),
        ),
      ),
    );
  }
}
