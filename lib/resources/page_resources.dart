import 'package:flutter/material.dart';

class ServiceAvatar extends StatelessWidget {
  ServiceAvatar({this.image, this.onTapped});
  final Image image;
  final Function onTapped;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: onTapped,
              child: CircleAvatar(
                backgroundImage: image.image,
                maxRadius: 55,
                minRadius: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//service title
class ServiceTitle extends StatelessWidget {
  ServiceTitle({this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.red,
        fontSize: 20,
      ),
    );
  }
}
