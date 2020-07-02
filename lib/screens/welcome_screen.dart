import 'package:firstaidpatient/screens/login_screen.dart';
import 'package:firstaidpatient/screens/registration_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('WELCOME'),
        backgroundColor: Color(0xFFC21A26),
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image.asset('images/Banner.png'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Material(
                elevation: 5,
                shadowColor: Colors.white,
                child: MaterialButton(
                  height: 42,
                  minWidth: 100,
                  padding: EdgeInsets.only(left: 20, right: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  textColor: Colors.white,
                  color: Color(0xFFC21A26),
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  child: Text(
                    'Login',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Material(
                elevation: 5,
                shadowColor: Colors.white,
                child: MaterialButton(
                  height: 42,
                  minWidth: 100,
                  padding: EdgeInsets.only(left: 20, right: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  textColor: Colors.white,
                  color: Color(0xFFC21A26),
                  onPressed: () {
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },
                  child: Text(
                    'SignUp',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
