import 'package:demoproject/Utilities/Toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ResponseCheck {
  void responseCheck(BuildContext context, Response, String email) {
    switch (Response.status) {
      case 200:
        Toast.show(Response.message, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM, backgroundColor: Theme.of(context).primaryColor);

        break;
      case 401:
        Toast.show(Response.message, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM, backgroundColor: Theme.of(context).primaryColor);
        break;
      case 400:
        Toast.show(Response.message, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM, backgroundColor: Theme.of(context).primaryColor);

        break;
      case 408:
        Toast.show(Response.message, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM, backgroundColor: Theme.of(context).primaryColor);
    }
  }
}
