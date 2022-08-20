import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        "Create Account",
        style: TextStyle(fontWeight: FontWeight.w600),
        textScaleFactor: 2,
      ),
    );
  }
}
