import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'Lyrics.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final auth = FirebaseAuth.instance;
  final db = Firestore.instance;

  GlobalKey<FormState> key = new GlobalKey<FormState>();
  String artist, song, uid, fname, lname, email, name;
  var user, isLoading = true;

  Future searchSong() async {
    if (key.currentState.validate()) {
      key.currentState.save();
      var response = await http.get(
          Uri.encodeFull('https://api.lyrics.ovh/v1/' + artist + '/' + song));

      var data = convert.jsonDecode(response.body);
      if (data['error'] != null) {
        showError("No lyrics found");
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Lyrics(
            lyrics: data['lyrics'].toString(),
            song: song,
            artist: artist,
          );
        }));
      }
    }
  }

  Future getUser() async {
    user = await auth.currentUser();
    db.collection('users').document(user.uid).get().then((value) {
      name = value.data['Name'];
      fname = name.split(' ')[0][0].toUpperCase();
      lname = name.split(' ')[1][0].toUpperCase();
      email = value.data['Email'];
      setState(() {
        isLoading = false;
      });
    });
  }

  showError(error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(error),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Ok'),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lyrix'),
      ),
      body: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 50)),
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('images/music.png'),
                )),
          ),
          SizedBox(
            height: 100,
          ),
          Column(
            children: <Widget>[
              Form(
                key: key,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        onSaved: (input) {
                          if (input.isNotEmpty) {
                            song = input;
                          }
                        },
                        validator: (input) {
                          if (input.isEmpty) {
                            return 'Provide a song';
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Song',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        onSaved: (input) {
                          if (input.isNotEmpty) {
                            artist = input;
                          }
                        },
                        validator: (input) {
                          if (input.isEmpty) {
                            return 'Provide a Artist';
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Artist',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              RaisedButton(
                padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                onPressed: searchSong,
                child: Text(
                  'Search',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.teal,
              )
            ],
          ),
        ],
      ),
      drawer: Drawer(
        child: isLoading
            ? CircularProgressIndicator()
            : ListView(
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountName: Text(name),
                    accountEmail: Text(email),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.teal,
                      child: Text(
                        fname + lname,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  ListTile(
                      title: Text('Home'),
                      leading: Icon(Icons.home),
                      onTap: () {
                        Navigator.of(context).pushNamed('/HomePage');
                      }),
                  ListTile(
                      title: Text('Favorites'),
                      leading: Icon(Icons.star),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed('/Favorites');
                      }),
                  ListTile(
                      title: Text('Account'),
                      leading: Icon(Icons.account_circle),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed('/Account');
                      }),
                  ListTile(
                    title: Text('Sign Out'),
                    leading: Icon(Icons.power_settings_new),
                    onTap: () async {
                      await auth.signOut();
                      Navigator.of(context).pop();
                      Navigator.pushReplacementNamed(context, '/SignIn');
                    },
                  ),
                  ListTile(
                    title: Text('Close'),
                    leading: Icon(Icons.close),
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
      ),
    );
  }
}
