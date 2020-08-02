import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final auth = FirebaseAuth.instance;
  final db = Firestore.instance;

  GlobalKey<FormState> key = new GlobalKey<FormState>();
  String fname, lname, email, password;

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
              child: Text('Ok'))
        ],
      ),
    );
  }

  Future checkDetails() async {
    if (key.currentState.validate()) {
      key.currentState.save();
      try {
        var result = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        var user = result.user;

        await db.collection('users').document(user.uid).setData(
            {'Name': fname + " " + lname, 'Email': email, 'Favorites': []});

        Navigator.pushReplacementNamed(context, '/HomePage');
      } catch (e) {
        showError(e.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lyrix'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 100),
              child: Text(
                'Create Account',
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              ),
            ),
            Form(
              key: key,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      onSaved: (input) {
                        if (input.isNotEmpty) {
                          fname = input;
                        }
                      },
                      validator: (input) {
                        if (input.isEmpty) {
                          return 'Provide First Name';
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'First Name',
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
                          lname = input;
                        }
                      },
                      validator: (input) {
                        if (input.isEmpty) {
                          return 'Provide Last Name';
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Last Name',
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
                          email = input;
                        }
                      },
                      validator: (input) {
                        if (input.isEmpty) {
                          return 'Provide an email';
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Email',
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
                          password = input;
                        }
                      },
                      obscureText: true,
                      validator: (input) {
                        if (input.isEmpty) {
                          return 'Provide a Password';
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Password',
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
              onPressed: checkDetails,
              child: Text(
                'Sign Up',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.teal,
            )
          ],
        ),
      ),
    );
  }
}
