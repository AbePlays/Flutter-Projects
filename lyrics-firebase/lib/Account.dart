import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final auth = FirebaseAuth.instance;
  final db = Firestore.instance;

  GlobalKey<FormState> key = new GlobalKey<FormState>();
  String fname, lname;

  Future saveToDB() async {
    if (key.currentState.validate()) {
      key.currentState.save();

      var user = await auth.currentUser();
      var name = fname + " " + lname;
      await db
          .collection("users")
          .document(user.uid)
          .updateData({"Name": name}).then((_) {
        print("success!");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Task Successfull'),
            content: Text("Name Changed Successfully"),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Ok'))
            ],
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Account Settings'),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 100)),
              Container(
                padding: EdgeInsets.only(bottom: 150),
                child: Text(
                  'Change Name',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              Form(
                key: key,
                child: Column(
                  children: <Widget>[
                    TextFormField(
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
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
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
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                onPressed: saveToDB,
                child: Text(
                  'Confirm',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.teal,
              ),
            ],
          ),
        ));
  }
}
