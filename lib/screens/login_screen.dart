import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstaidpatient/screens/bottom_navigation_bar.dart';
import 'package:firstaidpatient/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  String email, password;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Glad to have you'),
        backgroundColor: Color(0xFFC21A26),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Image.asset('images/logo.png'),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: <Widget>[
                          Flexible(
                            child: TextField(
                              onChanged: (value) {
                                email = value;
                              },
                              autofocus: true,
                              controller: _emailController,
                              decoration: InputDecoration(
                                hintText: 'Email',
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: TextField(
                              onChanged: (value) {
                                password = value;
                              },
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                prefixIcon: Icon(
                                  Icons.lock_open,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 18),
                      FlatButton(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        textColor: Colors.white,
                        color: Colors.redAccent,
                        onPressed: () async {
                          setState(() {
                            showSpinner = true;
                          });
                          try {
                            final newUser =
                                await _auth.signInWithEmailAndPassword(
                                    email: email, password: password);
                            if (newUser != null) {
                              Navigator.pushNamed(
                                  context, MyBottomNavigationBar.id);
                            }
                            setState(() {
                              showSpinner = false;
                            });
                          } catch (e) {
                            Alert(
                              context: context,
                              type: AlertType.error,
                              title: "Having trouble?",
                              desc: "Your email or password is incorrect",
                              buttons: [
                                DialogButton(
                                  child: Text(
                                    "OK",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () => Navigator.pushNamed(
                                      context, WelcomeScreen.id),
                                  width: 120,
                                )
                              ],
                            ).show();
                          }
                        },
                        child: Text(
                          'OK',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
//                      RaisedButton(
//                          child: Text('Google Sign In'),
//                          onPressed: () async {
//                            bool res = await AuthProvider().loginWithGoogle();
//                            if (!res) {
//                              print('Error With Google Sign In');
//                            }
//                          })
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
