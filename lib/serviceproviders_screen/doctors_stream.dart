import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';

class DoctorsStream extends StatefulWidget {
  static const String id = 'doctors_stream';

  ///final GeoLocationService _geoLocationService = GeoLocationService();

  @override
  _DoctorsStreamState createState() => _DoctorsStreamState();
}

class _DoctorsStreamState extends State<DoctorsStream> {
  GoogleMapController mapController;
  final _fireStore = Firestore.instance;
  FirebaseUser user;
//  Set<Marker> _marker = HashSet<Marker>();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  //int id = Random().nextInt(100);
  Stream<List<DocumentSnapshot>> stream;
  var radius = BehaviorSubject<double>.seeded(1.0);
  Geolocator geoLocator = Geolocator();
  Geoflutterfire geoFlutterFire = Geoflutterfire();
  Position position;

//get users location
  getCurrentPosition() async {
    position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
  }

//RX dart calculation of distance using behaviour subject
  //BehaviorSubject<double> radius = BehaviorSubject.seeded(5.0);
  //var radius = BehaviorSubject<double>.seeded(1.0);
  Stream<dynamic> query;
  StreamSubscription subscription;

  //Update markers from firebase reactively
//  _updateMarkers(List<DocumentSnapshot> documentList) {
//    print(documentList);
//    //final List<Marker> _marker = [];
//    documentList.forEach((DocumentSnapshot document) {
//      GeoPoint pos = document.data['position']['geopoint'];
//      double distance = document.data['distance'];
//      setState(() {
//        _marker.add(
//          Marker(
//            position: LatLng(pos.latitude, pos.longitude),
//            markerId: MarkerId(id.toString()),
//            infoWindow: InfoWindow(
//              title: 'Doctor is $distance from you',
//              onTap: () {
//                //navigate to Doctors profile screen to show all info plus video and chat
//              },
//            ),
//          ),
//        );
//      });
//    });
//  }

  _startQuery() async {
    try {
      // Get querying phone location
      var pos = await geoLocator.getCurrentPosition();
      double userLatitude = pos.latitude;
      double userLongitude = pos.longitude;
      // get center points from users location
      GeoFirePoint center = geoFlutterFire.point(
          latitude: userLatitude, longitude: userLongitude);
      stream = radius.switchMap((rad) {
        //make a firestore reference
        var ref = _fireStore.collection('doctorsLocation');
        //query data from firestore
        return geoFlutterFire.collection(collectionRef: ref).within(
            center: center, radius: rad, field: 'position', strictMode: true);
      });
      // subscribe to query
//      subscription = radius.switchMap((rad) {
//        return geoflutterfire.collection(collectionRef: ref).within(
//            center: center, radius: rad, field: 'position', strictMode: true);
//      }).listen((List<DocumentSnapshot> documentList) {
//        _updateMarkers(documentList);
//      });
      //radius.add(5);
//      double radius = 5;
//      String field = 'position';
//      var ref = _firestore.collection('doctorsLocation');
//      Stream<List<DocumentSnapshot>> stream = geoflutterfire
//          .collection(collectionRef: ref)
//          .within(
//              center: center, radius: radius, field: field, strictMode: true);
////      stream//      });.listen((List<DocumentSnapshot> documentList) {
////        _updateMarkers(documentList);
    } catch (e) {
      print(e);
    }
  }

//update query as you drag slider
  _updateQuery(double newValue) {
    try {
      final zoomMap = {
        100.0: 12.0,
        200.0: 10,
        300.0: 7,
        400.0: 6,
        500.0: 5.0,
      };
      final zoom = zoomMap[newValue];
      mapController.moveCamera(
        CameraUpdate.zoomTo(zoom),
      );
      setState(() {
        radius.add(newValue);
      });
    } catch (e) {
      print(e);
    }
  }

  TextEditingController _latitudeController, _longitudeController;
  @override
  void initState() {
    super.initState();
    getCurrentPosition();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startQuery();
    });

    _latitudeController = TextEditingController();
    _longitudeController = TextEditingController();
  }

  @override
  dispose() {
    subscription.cancel();
    radius.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: position == null
            ? CircularProgressIndicator()
            : Center(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: <Widget>[
                      GoogleMap(
                        initialCameraPosition: CameraPosition(
                            target:
                                LatLng(position.latitude, position.longitude),
                            zoom: 17,
                            tilt: 12.0),
                        onMapCreated: _onMapCreated,
                        myLocationEnabled: true,
                        mapType: MapType.terrain,
                        markers: Set<Marker>.of(markers.values),
                      ),
                      Positioned(
                        bottom: 50,
                        left: 10,
                        child: Slider(
                          min: 1.0,
                          max: 5.0,
                          value: _value,
                          label: _label,
                          activeColor: Colors.green,
                          inactiveColor: Colors.red,
                          onChanged: (double value) => changed(value),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            width: 100,
                            child: TextField(
                              controller: _latitudeController,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  labelText: 'lat',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  )),
                            ),
                          ),
                          Container(
                            width: 100,
                            child: TextField(
                              controller: _longitudeController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  labelText: 'lng',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  )),
                            ),
                          ),
                          MaterialButton(
                            color: Colors.blue,
                            onPressed: () {
                              double lat =
                                  double.parse(_latitudeController.text);
                              double lng =
                                  double.parse(_longitudeController.text);
                              _addPoint(lat, lng);
                            },
                            child: Text(
                              'ADD',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

//Add Geopoint
  void _addPoint(double lat, double lng) {
    GeoFirePoint geoFirePoint =
        geoFlutterFire.point(latitude: lat, longitude: lng);
    _fireStore
        .collection('doctorsLocation')
        .add({'name': 'Doctor', 'position': geoFirePoint.data}).then((_) {
      print('added ${geoFirePoint.hash} successfully');
    });
  }

//  void _onMapCreated(GoogleMapController controller) {
//    _startQuery();
//    setState(() {
//      mapController = controller;
//    });
//  }
  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _animateToUser();
      mapController = controller;
      //start listening after map is created
      stream.listen((List<DocumentSnapshot> documentList) {
        _updateMarkers(documentList);
      });
    });
  }

//add marker
  void _addMarker(double lat, double lng) {
    MarkerId id = MarkerId(lat.toString() + lng.toString());
    Marker _marker = Marker(
      markerId: id,
      position: LatLng(lat, lng),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
      infoWindow: InfoWindow(title: 'latLng', snippet: '$lat,$lng'),
    );
    setState(() {
      markers[id] = _marker;
    });
  }

  void _animateToUser() async {
    var pos = await getCurrentPosition();
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(pos.latitude, pos.latitude),
          zoom: 17.0,
        ),
      ),
    );
  }

  void _updateMarkers(List<DocumentSnapshot> documentList) {
    documentList.forEach((DocumentSnapshot document) {
      GeoPoint pos = document.data['position']['geopoint'];
      _addMarker(pos.latitude, pos.longitude);
      double distance = document.data['distance'];
    });
  }

  double _value = 1.0;
  String _label = '';

  changed(value) {
    setState(() {
      _value = value;
      _label = '${_value.toInt().toString()} kms';
      markers.clear();
    });
    radius.add(value);
  }
}
