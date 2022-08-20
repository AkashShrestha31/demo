import 'package:demoproject/Constants/SizeConfig.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CircularProfile extends StatelessWidget {
  String username;
  String image_uri;
  double radius;

  CircularProfile({this.username, this.image_uri, this.radius});

  @override
  Widget build(BuildContext context) {
    Widget returnProfileimage(String imageUri, String name) {
      if (imageUri != null) {
        return Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 2), shape: BoxShape.circle, color: Theme.of(context).primaryColor),
          child: CircleAvatar(radius: radius, backgroundImage: new NetworkImage(imageUri)),
        );
      } else {
        return CircleAvatar(
          radius: radius,
          child: Container(
            decoration:
                BoxDecoration(border: Border.all(color: Colors.white, width: 2), shape: BoxShape.circle, color: Theme.of(context).primaryColor),
            child: Center(
              child: Text(
                name[0].toUpperCase(),
                style: TextStyle(
                  fontSize: SizeConfig.safeBlockHorizontal * 6,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
      }
    }

    return returnProfileimage(image_uri, username);
  }
}
