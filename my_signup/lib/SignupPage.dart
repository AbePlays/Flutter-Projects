import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'HomePage.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  bool _autovalidate = false;

  _sendToNextScreen() {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      Navigator.push(context, 
        MaterialPageRoute(
          builder: (context) => HomePage(
            name: name,
            mobile: mobile,
            email: email,
            clgname: clgname,
            pwd: pwd,
          )
        )      
      );
    } else {
      setState(() {
       _autovalidate = true; 
      });
    }
  }

  String name, email, mobile, clgname, pwd;

  GlobalKey<FormState> _key = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: SingleChildScrollView(
          child: Form(
          key: _key,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)
            ),
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.all(10.0),),
                Image(
                  image: AssetImage('images/logo.png'),
                  width: 100.0,
                  height: 100.0,
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: TextFormField(
                    validator: (input) {
                      if (input.isEmpty) {
                        return 'Enter Name';
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Name',
                    ),
                    onSaved: (input) => name = input
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.email),
                  title: TextFormField(
                    validator: (input) {
                      if (input.isEmpty) {
                        return 'Enter Email';
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                    onSaved: (input) => email = input
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.security),
                  title: TextFormField(
                    validator: (input) {
                      if (input.isEmpty) {
                        return 'Enter Password';
                      }
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    onSaved: (input) => pwd = input
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.phone),
                  title: TextFormField(
                    validator: (input) {
                      if (input.isEmpty) {
                        return 'Enter Phone Number';
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                    ),
                    onSaved: (input) => mobile = input
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.school),
                  title: TextFormField(
                    validator: (input) {
                      if (input.isEmpty) {
                        return 'Enter Name of the School';
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Collge Name',
                    ),
                    onSaved: (input) => clgname = input
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                ),
                ButtonTheme(
                  height: 40.0,
                  minWidth: 200.0,
                  child: RaisedButton(
                    onPressed: _sendToNextScreen,
                    color: Colors.orange,
                    child: Text('Save' , style: TextStyle(
                      color: Colors.white,
                    ),
                   ),
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(10.0),
                   ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 28),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}