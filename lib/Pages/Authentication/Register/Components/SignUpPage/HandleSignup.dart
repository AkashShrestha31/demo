import 'package:demoproject/Bloc/Authentication/Signup/SignupBloc.dart';
import 'package:demoproject/Constants/SizeConfig.dart';
import 'package:demoproject/Model/Authentication/SignupModel/SignupResponseModel.dart';
import 'package:demoproject/Pages/Authentication/Register/Components/ResponeCheck.dart';
import 'package:demoproject/Repository/Repository.dart';
import 'package:flutter/material.dart';

class SignupHandler extends StatefulWidget {
  final String email, firstname, lastname, phone, password;
  final GlobalKey<FormState> formkey;
  SignupHandler({
    Key key,
    this.email,
    this.firstname,
    this.lastname,
    this.phone,
    this.password,
    this.formkey,
  }) : super(key: key);

  @override
  _SignupHandlerState createState() => _SignupHandlerState();
}

class _SignupHandlerState extends State<SignupHandler> {
  ResponseCheck functionality = ResponseCheck();

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: SizeConfig.screenWidth * 0.4,
      child: new RaisedButton(
          elevation: 1,
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.all(Radius.circular(SizeConfig.safeBlockHorizontal * 2)),
              side: BorderSide(color: Theme.of(context).primaryColor)),
          padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 2.6),
          color: Theme.of(context).primaryColor,
          onPressed: () async {
            if (widget.formkey.currentState.validate()) {
              //dictionary
              signUpBloc.updateLoading(true);

              var body = {
                "email": widget.email,
                "password": widget.password,
                "profile": {
                  "first_name": widget.firstname,
                  "last_name": widget.lastname,
                  "phone": widget.phone,
                  "image_uri": null,
                  "device_identifier": "98##11",
                  "login_type": "custom"
                }
              };

              SignupResponseModel response = await repository.getSignUpResponse(body);
              functionality.responseCheck(context, response, widget.email);
            }
          },
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                "SIGN UP",
                style: TextStyle(
                    fontStyle: FontStyle.normal, fontSize: SizeConfig.safeBlockHorizontal * 3.5, color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ],
          )),
    );
  }
}
