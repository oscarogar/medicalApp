import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstaidpatient/messaging/chat.dart';
import 'package:firstaidpatient/resources/page_resources.dart';
import 'package:firstaidpatient/serviceproviders_screen/doctors_stream.dart';
import 'package:flutter/material.dart';

class ServicesPage extends StatefulWidget {
  static const String id = 'services_page';
  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;

  void getCoord() async {
    // Location location Location();
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SERVICES'),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Color(0xFFC21A26),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            color: Colors.white,
            onPressed: () async {
              try {
                await _auth.signOut();
              } catch (e) {
                print(e);
              }
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: (Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              ServiceAvatar(
                image: Image.asset('images/doctor.jpeg'),
                onTapped: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return DoctorsStream();
                  }));
                },
              ),
              ServiceAvatar(
                  image: Image.asset('images/nurse.jpg'),
                  onTapped: () {
                    Navigator.pushNamed(context, ChatScreen.id);
                  }),
              ServiceAvatar(
                image: Image.asset('images/lab.jpeg'),
                onTapped: () {
                  //navigate
                },
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ServiceTitle(
                title: 'Doctor',
              ),
              ServiceTitle(
                title: 'Nurse',
              ),
              ServiceTitle(
                title: 'Laboratory',
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              ServiceAvatar(
                image: Image.asset('images/paediatrics.jpg'),
                onTapped: () {
                  //navigate
                },
              ),
              ServiceAvatar(
                image: Image.asset('images/pharm.jpg'),
                onTapped: () {},
              ),
              ServiceAvatar(
                image: Image.asset('images/counselor.jpg'),
                onTapped: () {
                  //navigate
                },
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ServiceTitle(
                title: 'Paediatrician',
              ),
              ServiceTitle(
                title: 'Pharmacist',
              ),
              ServiceTitle(
                title: 'Counselor',
              ),
            ],
          ),
        ],
      )),
    );
  }
}
