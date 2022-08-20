import 'package:flutter/material.dart';

class FailedConnection extends StatefulWidget {
  @override
  _FailedConnectionState createState() => _FailedConnectionState();
}

class _FailedConnectionState extends State<FailedConnection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Icon(
          Icons.wifi_off,
          size: 50,
        ),
      ),
    );
  }
}
