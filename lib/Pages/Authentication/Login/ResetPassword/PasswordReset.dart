import 'package:connectivity/connectivity.dart';
import 'package:demoproject/Constants/SizeConfig.dart';
import 'package:demoproject/Model/Authentication/SignupModel/SignupResponseModel.dart';
import 'package:demoproject/Pages/Authentication/Login/ResetPassword/PasswordResetConfirmation.dart';
import 'package:demoproject/Pages/Authentication/Register/Components/CircularSpinner.dart';
import 'package:demoproject/Repository/Repository.dart';
import 'package:demoproject/Utilities/Toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PasswordReset extends StatefulWidget {
  @override
  _PasswordResetState createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  bool is_loading = false;

  TextEditingController emailcontroller = new TextEditingController();
  final GlobalKey<FormState> formkey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.white,
            appBar: new AppBar(
              title: Text(
                "forget_password",
                style: TextStyle(
                    color: Colors.black, fontStyle: FontStyle.normal, fontSize: SizeConfig.safeBlockHorizontal * 4, fontWeight: FontWeight.w500),
              ).tr(),
              elevation: 0,
              backgroundColor: Colors.white,
              leading: InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      size: SizeConfig.safeBlockHorizontal * 4.5,
                    ),
                  ],
                ),
              ),
              iconTheme: IconThemeData(
                color: Colors.black, //change your color here
              ),
//          automaticallyImplyLeading: false,
            ),
            body: Container(
                color: Colors.white,
                height: SizeConfig.screenHeight,
                child: Form(
                  key: formkey,
                  child: Padding(
                    padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 5),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: SizeConfig.safeBlockHorizontal * 4,
                          ),
                          Text(
                            "password_reset_message",
                            style:
                                TextStyle(fontStyle: FontStyle.normal, fontSize: SizeConfig.safeBlockHorizontal * 3.2, fontWeight: FontWeight.w400),
                            textScaleFactor: 1.3,
                          ).tr(),
                          SizedBox(
                            height: SizeConfig.safeBlockHorizontal * 8,
                          ),
                          Image.asset(
                            "assets/Images/reset-pw.png",
                            scale: SizeConfig.safeBlockHorizontal * 0.6,
                          ),
                          SizedBox(
                            height: SizeConfig.safeBlockHorizontal * 8,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.done,
                            textAlign: TextAlign.start,
                            controller: emailcontroller,
                            cursorColor: Theme.of(context).primaryColor,
                            style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontSize: SizeConfig.safeBlockHorizontal * 3.4,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                            onTap: () {},
                            maxLines: 1,
                            minLines: 1,
                            decoration: new InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(SizeConfig.safeBlockHorizontal * 2),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 1.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(SizeConfig.safeBlockHorizontal * 2),
                                borderSide: BorderSide(
                                  color: Colors.grey[300],
                                ),
                              ),
                              errorMaxLines: 4,
                              errorStyle: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontSize: SizeConfig.safeBlockHorizontal * 3.4,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w400),
                              isDense: true,
                              contentPadding: EdgeInsets.fromLTRB(SizeConfig.safeBlockHorizontal * 4, SizeConfig.safeBlockHorizontal * 2,
                                  SizeConfig.safeBlockHorizontal * 4, SizeConfig.safeBlockHorizontal * 2),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(SizeConfig.safeBlockHorizontal * 2),
                                ),
                              ),
                              prefixIcon: Icon(
                                FontAwesomeIcons.envelope,
                                size: SizeConfig.safeBlockHorizontal * 4,
                              ),
                              filled: true,
                              hintStyle: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontSize: SizeConfig.safeBlockHorizontal * 3.4,
                                  color: Colors.grey[300],
                                  fontWeight: FontWeight.w400),
                              hintText: "email".tr(),
                              fillColor: Colors.white,
                            ),
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'please_enter_your_valid_email'.tr();
                              }

                              if (!RegExp(
                                      "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$")
                                  .hasMatch(value)) {
                                return 'please_enter_your_valid_email'.tr();
                              }

                              return null;
                            },
                          ),
                          SizedBox(
                            height: SizeConfig.safeBlockHorizontal * 10,
                          ),
                          Container(
                            // width: SizeConfig.screenWidth * 0.4,
                            child: new RaisedButton(
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.all(Radius.circular(SizeConfig.safeBlockHorizontal * 2)),
                                    side: BorderSide(color: Theme.of(context).primaryColor)),
                                padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 2.6),
                                color: Theme.of(context).primaryColor,
                                onPressed: () async {
                                  if (formkey.currentState.validate()) {
                                    Connectivity().checkConnectivity().then((value) async {
                                      if (value != ConnectivityResult.none) {
                                        setState(() {
                                          is_loading = true;
                                        });

                                        var body = emailcontroller.text;
                                        SignupResponseModel response = await repository.resetMailResponse(body = emailcontroller.text.toLowerCase());

                                        if (response != null) {
                                          setState(() {
                                            is_loading = false;
                                          });
                                        }
                                        switch (response.status) {
                                          case 200:
                                            Toast.show(response.message, context,
                                                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM, backgroundColor: Theme.of(context).primaryColor);
                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                              return PasswordResetConfirmation();
                                            }));

                                            break;
                                          case 404:
                                            Toast.show(response.message, context,
                                                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM, backgroundColor: Theme.of(context).primaryColor);
                                        }
                                      } else {
                                        Toast.show("check_internet".tr(), context,
                                            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM, backgroundColor: Theme.of(context).primaryColor);
                                      }
                                    });
                                  }
                                },
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Text(
                                      "reset_password",
                                      style: TextStyle(
                                          fontStyle: FontStyle.normal,
                                          fontSize: SizeConfig.safeBlockHorizontal * 3.5,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ).tr(),
                                  ],
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                )),
          ),
          CircularSpinner(is_loading: is_loading)
        ],
      ),
    );
  }
}
