import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser user;
  bool isSignedIn = false;

  checkAuthentication() async {
    _auth.onAuthStateChanged.listen((user) {
      if (user == null) {
        Navigator.pushReplacementNamed(context, "/SigninPage");
      }
    });
  }

  getUser() async {
    FirebaseUser firebaseUser = await _auth.currentUser();
    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isSignedIn = true;
      });
    }
  }

  signOut() {
    _auth.signOut();
  }

  @override
  void initState() {
    super.initState();
    this.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        child: Center(
            child: !isSignedIn
                ? CircularProgressIndicator()
                : Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(50),
                        child: Image(
                          image: AssetImage('assets/logo.png'),
                          width: 100,
                          height: 100,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(50),
                        child: Text(
                          'Hello, ${user.displayName}!! You\'re logged in as ${user.email}',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: RaisedButton(
                          color: Colors.teal,
                          padding: EdgeInsets.fromLTRB(100, 20, 100, 20),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          onPressed: signOut,
                          child: Text(
                            'Sign Out',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      )
                    ],
                  )),
      ),
    );
  }
}
