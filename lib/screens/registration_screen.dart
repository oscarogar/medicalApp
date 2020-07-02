import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstaidpatient/resources/expertise.dart';
import 'package:firstaidpatient/resources/text_form_field.dart';
import 'package:firstaidpatient/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class RegistrationScreen extends StatelessWidget {
  static const String id = 'RegistrationScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Color(0xFFC21A26),
        title: Text('Fill the Form'),
      ),
      body: TextForm(),
    );
  }
}

class TextForm extends StatefulWidget {
  @override
  _TextFormState createState() => _TextFormState();
}

class _TextFormState extends State<TextForm> {
  final _fireStore = Firestore.instance;
  String selectedExpertise;
  final _auth = FirebaseAuth.instance;

  List<DropdownMenuItem> getExpertise() {
    List<DropdownMenuItem<String>> work = [];
    for (String expertise in expertiseList) {
      var newItem = DropdownMenuItem(
        child: Text(expertise),
        value: expertise,
      );
      work.add(newItem);
    }
    return work;
  }

  String confirmPass, confirmPass2, firstName, lastName, phone, email;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size.width / 2.0;
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: _screenSize,
                child: MyTextFormField(
                  onChanged: (value) => lastName = value,
                  hintText: 'First Name',
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'Enter your First name';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                width: _screenSize,
                child: MyTextFormField(
                  onChanged: (value) => firstName = value,
                  hintText: 'Last Name',
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'Enter your Last Name';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          MyTextFormField(
            onChanged: (value) => email = value,
            hintText: 'Email',
            isEmail: true,
            validate: (String value) {
              if (value.isEmpty) {
                return 'Enter your Email';
              }
              return null;
            },
          ),
          MyTextFormField(
            onChanged: (value) => phone = value,
            hintText: 'Phone',
            validate: (String value) {
              if (value.isEmpty) {
                return 'Enter your Phone Number';
              }
              return null;
            },
          ),
          DropdownButton<String>(
              value: selectedExpertise,
              hint: Text('You are a'),
              items: getExpertise(),
              onChanged: (value) {
                setState(() {
                  selectedExpertise = value;
                });
              }),
          MyTextFormField(
            hintText: 'Password',
            onChanged: (value) => confirmPass = value,
            validate: (String value) {
              if (confirmPass.length < 7) {
                return 'Password too short';
              }
              _formKey.currentState.save();
              return null;
            },
            onSaved: (String value) {},
            isPassword: true,
          ),
          MyTextFormField(
            hintText: 'Confirm Password',
            onChanged: (value) => confirmPass2 = value,
            validate: (String value) {
              if (confirmPass != confirmPass2) {
                return "Password don\'t match";
              }
              return null;
            },
            isPassword: true,
          ),
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 5,
            textColor: Colors.white,
            child: Text(
              'Submit',
              style: TextStyle(fontSize: 20),
            ),
            color: Color(0xFFC21A26),
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                _fireStore.collection('users').add({
                  'first_name': firstName,
                  'last_name': lastName,
                  'phone': phone,
                  'email': email,
                  'password': confirmPass,
                  'user_type': selectedExpertise,
                });
                Alert(
                  context: context,
                  type: AlertType.success,
                  title: "Thank You For Registering",
                  desc: " Kindly Proceed to Login",
                  buttons: [
                    DialogButton(
                      child: Text(
                        "OK",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      width: 120,
                      onPressed: () async {
                        try {
                          final newUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: email, password: confirmPass);
//                            .then((value) async {
//                          var userUpdateInfo =
//                              UserUpdateInfo(); //create user update object
//                          userUpdateInfo.displayName = "John Doe";
//                          await value.user.updateProfile(
//                              userUpdateInfo); //update to firebase
//                          await value.user.reload(); //reload  user data
//                        });
                          if (newUser != null) {
                            Navigator.pushNamed(context, LoginScreen.id);
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                    )
                  ],
                ).show();
              }
            },
          ),
        ],
      ),
    );
  }
}
