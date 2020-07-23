import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email, _password;

  checkAuthentication() async {
    _auth.onAuthStateChanged.listen((user) async {
      if(user != null) {
        Navigator.pushReplacementNamed(context, "/");
      }
    });
  }

  navigateToSignupScreen() {
    Navigator.pushReplacementNamed(context, "/SignupPage");
  }

  void initState() {
    super.initState();
    this.checkAuthentication();
  }

  void signin() async {
    if(_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        FirebaseUser user = await _auth.signInWithEmailAndPassword(
          email: _email,
          password: _password,
        );
      } catch (e) {
        showError(e.message);
      }
    }
  }

  showError(String error) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(error),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In')
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(10, 50, 10, 30),
              child: Image(image: AssetImage('assets/logo.png'),
              width: 100,
              height: 100,
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: TextFormField(
                        validator: (input) {
                          if(input.isEmpty) {
                            return 'Provide an email';
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          )
                        ),
                        onSaved: (input) => _email = input ,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: TextFormField(
                        validator: (input) {
                          if(input.length < 6) {
                            return 'Atleast 6 character';
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          )
                        ),
                        onSaved: (input) => _password = input,
                        obscureText: true,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 15, 20, 18),
                      child: RaisedButton(
                        padding: EdgeInsets.fromLTRB(100, 20, 100, 20),
                        child: Text('Sign In', style: TextStyle(
                          fontSize: 20,
                          color: Colors.white
                        )),
                        color: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        onPressed: signin,
                      ),
                    ),
                    GestureDetector(
                      onTap: navigateToSignupScreen,
                      child: Text('Create an account', textAlign: TextAlign.center, style: TextStyle(
                        fontSize: 16.0
                      ), ),
                    )
                  ],
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}