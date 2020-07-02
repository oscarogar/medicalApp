import 'package:firstaidpatient/messaging/chat.dart';
import 'package:firstaidpatient/resources/geolocation_services.dart';
import 'package:firstaidpatient/screens/bottom_navigation_bar.dart';
import 'package:firstaidpatient/screens/login_screen.dart';
import 'package:firstaidpatient/screens/profile_page.dart';
import 'package:firstaidpatient/screens/registration_screen.dart';
import 'package:firstaidpatient/screens/services_page.dart';
import 'package:firstaidpatient/screens/welcome_screen.dart';
import 'package:firstaidpatient/serviceproviders_screen/doctors_stream.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(FirstAidPatient());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class FirstAidPatient extends StatelessWidget {
  final geoService = GeoLocationService();
  @override
  Widget build(BuildContext context) {
    return FutureProvider(
      create: (context) => geoService.initialPosition(),
      child: MaterialApp(
        theme: ThemeData.light(),
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          MyBottomNavigationBar.id: (context) => MyBottomNavigationBar(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          ProfilePage.id: (context) => ProfilePage(),
          ServicesPage.id: (context) => ServicesPage(),
          ChatScreen.id: (context) => ChatScreen(),
          DoctorsStream.id: (context) => DoctorsStream(),
        },
      ),
    );
  }
}
