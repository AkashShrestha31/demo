import 'package:demoproject/Constants/SizeConfig.dart';
import 'package:flutter/material.dart';

class CircularSpinner extends StatefulWidget {
  bool is_loading;
  CircularSpinner({
    Key key,
    this.is_loading,
  }) : super(key: key);

  @override
  _CircularSpinnerState createState() => _CircularSpinnerState();
}

class _CircularSpinnerState extends State<CircularSpinner> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.is_loading
          ? Container(
              height: SizeConfig.screenHeight,
              width: SizeConfig.screenWidth,
              color: Color.fromRGBO(128, 128, 128, 0.5),
              child: Center(
                child: CircularProgressIndicator(backgroundColor: Colors.white, strokeWidth: 1),
              ),
            )
          : Container(),
    );
  }
}
