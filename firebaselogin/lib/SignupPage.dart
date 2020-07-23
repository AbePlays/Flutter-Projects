import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _name, _email, _password;

  checkAuthentication() async {
    _auth.onAuthStateChanged.listen((user) {
      if(user != null) {
        Navigator.pushReplacementNamed(context, "/");
      }
    });
  }

  navigateToSigninScreen() {
    Navigator.pushReplacementNamed(context, "/SigninPage");
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
  }

  signup() async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();

      try {
        FirebaseUser user = await _auth.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        );

        if(user != null) {
          UserUpdateInfo updateUser = UserUpdateInfo();
          updateUser.displayName = _name;
          user.updateProfile(updateUser);
        }
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
        title: Text('Sign Up')
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(10, 30, 10, 20),
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
                            return 'Provide a Valid Name';
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          )
                        ),
                        onSaved: (input) => _name = input ,
                      ),
                    ),
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
                      padding: EdgeInsets.fromLTRB(20, 25, 20, 5),
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
                        onPressed: signup,
                      ),
                    ),
                    /* GestureDetector(
                      onTap: navigateToSigninScreen,
                      child: Text('Create an account', textAlign: TextAlign.center, style: TextStyle(
                        fontSize: 16.0
                      ), ),
                    ) */
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