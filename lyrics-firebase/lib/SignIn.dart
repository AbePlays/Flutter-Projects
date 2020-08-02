import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'SignUp.dart';
import 'dart:async';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  FirebaseAuth auth = FirebaseAuth.instance;
  GlobalKey<FormState> key = new GlobalKey<FormState>();
  String email, password;

  checkAuthentication() async {
    auth.onAuthStateChanged.listen((user) {
      if (user != null) {
        Navigator.pushReplacementNamed(context, "/HomePage");
      }
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
              child: Text('Ok'))
        ],
      ),
    );
  }

  Future checkDetails() async {
    if (key.currentState.validate()) {
      key.currentState.save();
      try {
        AuthResult result = await auth.signInWithEmailAndPassword(
            email: email, password: password);
        print(result.user.email);
        Navigator.pushReplacementNamed(context, '/HomePage');
      } catch (e) {
        showError(e.message);
      }
    }
  }

  goToSignUp() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return SignUp();
    }));
  }

  @override
  void initState() {
    super.initState();
    checkAuthentication();
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
                "Welcome Back!",
                style: TextStyle(fontSize: 30),
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
                'Sign In',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.teal,
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              child: Text('Create an account?'),
              onTap: goToSignUp,
            )
          ],
        ),
      ),
    );
  }
}
