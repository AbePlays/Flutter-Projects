import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  final db = Firestore.instance;
  final auth = FirebaseAuth.instance;
  var favorites = [], isLoading = true;

  Future doWork() async {
    try {
      var user = await auth.currentUser();
      var uid = user.uid;

      db.collection('users').document(uid).get().then((value) {
        favorites = value.data['Favorites'];
        setState(() {
          isLoading = false;
        });
      });
    } catch (e) {
      print(e.message);
    }
  }

  @override
  void initState() {
    super.initState();
    doWork();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : favorites.length == 0
                ? Text('Favorites empty.')
                : ListView.builder(
                    itemCount: this.favorites.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Container(
                            padding:
                                EdgeInsets.only(top: 8, left: 10, right: 10),
                            child: Icon(Icons.music_note)),
                        title: Text(favorites[index]['song']),
                        subtitle: Text(favorites[index]['artist']),
                        onTap: () {},
                      );
                    },
                  ),
      ),
    );
  }
}
