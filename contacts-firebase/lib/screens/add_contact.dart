import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:io';
import '../model/contact.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class AddContact extends StatefulWidget {
  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {

  DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();

  String _firstName = '';
  String _lastName = '';
  String _phone = '';
  String _email = '';
  String _address = '';
  String _photoUrl = 'empty';

  saveContact(BuildContext context) async {
    if(_firstName.isNotEmpty && _lastName.isNotEmpty && _phone.isNotEmpty && _email.isNotEmpty && _address.isNotEmpty ) {
      Contact contact = Contact(this._firstName, this._lastName, this._phone, this._email, this._address, this._photoUrl);
      await _databaseReference.push().set(contact.toJson());
      navigateToLastScreen(context);
    } else {
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Text('Error Saving Contact'),
          content: Text('Field Cannot Be Empty'),
          actions: <Widget>[
            FlatButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
    }
  }

  Future pickImage() async {
    File file = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 200,
      maxWidth: 200,
    );
    String filename = basename(file.path);
    uploadImage(file, filename);
  }

  uploadImage(File file, String filename) async {
    StorageReference storageReference = FirebaseStorage.instance.ref().child(filename);
    storageReference.putFile(file).onComplete.then((firebaseFile) async {
      var downloadUrl = await firebaseFile.ref.getDownloadURL();
      setState(() {
       _photoUrl = downloadUrl; 
      });
    });
  }

  navigateToLastScreen(context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add A New Contact'),
      ),
      body: Container(
        child: Padding(padding: EdgeInsets.all(20),
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20),
                child: GestureDetector(
                  onTap: () {
                    this.pickImage();
                  },
                  child: Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: _photoUrl == 'empty' ? AssetImage('assets/logo.png') : NetworkImage(_photoUrl) , 
                        )
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                     _firstName = value; 
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    )
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                     _lastName = value; 
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    )
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                     _phone = value; 
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    )
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                     _email = value; 
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    )
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                     _address = value; 
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    )
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: RaisedButton(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  onPressed: () {
                    saveContact(context);
                  },
                  color: Colors.green,
                  child: Text('Save', style: TextStyle(
                    fontSize: 20, color: Colors.white
                  ), ),
                ),
              )
            ],
          ),),
      ),
    );
  }
}