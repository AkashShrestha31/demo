import 'package:demoproject/Constants/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GooglebuildBody extends StatefulWidget {
  @override
  GooglebuildBodyState createState() => GooglebuildBodyState();
}

class GooglebuildBodyState extends State<GooglebuildBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight * 0.055,
      child: FloatingActionButton(
        heroTag: "google",
        backgroundColor: Color.fromRGBO(219, 50, 54, 1),
        elevation: 0,
        onPressed: () {},
        child: Icon(
          FontAwesomeIcons.google,
          color: Colors.white,
        ),
      ),
    );
  }
}
