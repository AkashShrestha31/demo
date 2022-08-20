import 'dart:convert';

import 'package:demoproject/Constants/Constants.dart';
import 'package:demoproject/Constants/SizeConfig.dart';
import 'package:demoproject/Model/Authentication/LoginModel/login_model.dart';
import 'package:demoproject/Model/Authentication/SignupModel/SignupResponseModel.dart';
import 'package:demoproject/Pages/Authentication/Login/Login.dart';
import 'package:demoproject/Pages/Authentication/Register/SignUpPage.dart';
import 'package:demoproject/Repository/Repository.dart';
import 'package:demoproject/Utilities/Toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class SignInChoice extends StatefulWidget {
  @override
  _SignInChoiceState createState() => _SignInChoiceState();
}

class _SignInChoiceState extends State<SignInChoice> {
  bool is_loading = false;
  void handleResponse(LoginModel onValue, BuildContext context) {
    switch (onValue.statusCode) {
      case 202:
        Toast.show(onValue.message, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM, backgroundColor: Theme.of(context).primaryColor);
        final box = GetStorage();
        box.write('token', onValue.accessToken);
        box.write('userinfo', onValue.userInfo.toJson());
        break;
      case 401:
        Toast.show(onValue.message, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM, backgroundColor: Theme.of(context).primaryColor);
        break;
    }
  }

  Future<void> handleUserInfo(String email, String displayName, String type) async {
    if (email != null) {
      setState(() {
        is_loading = true;
      });
      var body = {
        "email": email,
        "password": "",
        "profile": {
          "first_name": displayName.contains(" ") ? displayName.split(" ")[0] : displayName,
          "last_name": displayName.contains(" ") ? displayName.split(" ")[1] : "",
          "phone": "",
          "image_uri": null,
          "device_identifier": "98##11",
          "login_type": type
        }
      };
      SignupResponseModel response = await repository.getSignUpResponse(body);
      switch (response.status) {
        case 201:
          getDeviceId().then((value) {
            FirebaseMessaging.instance.subscribeToTopic(value);
            Future<dynamic> tokenmodel = repository.sendSuccesslogin(email, "q", value, type);
            tokenmodel.then((onValue) {
              setState(() {
                is_loading = false;
              });
              handleResponse(onValue, context);
            });
          });
          break;
      }
    }
  }

  void signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();
    if (loginResult.status == LoginStatus.success) {
      // you are logged
      final AccessToken accessToken = loginResult.accessToken;
      final graphResponse = await http.get(Uri.parse(
          'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.width(320).height(320) &access_token=${accessToken.token}'));
      final profile = json.decode(graphResponse.body);
      handleUserInfo(profile['email'], profile['name'], 'facebook');
    }
  }

  Future<void> _GooglehandleSignIn() async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
      handleUserInfo(googleUser.email, googleUser.displayName, 'google');
    } catch (error) {}
  }

  init() async {
    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Stack(
        children: [
          Scaffold(
            body: SafeArea(
              child: Container(
                padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 5),
                height: SizeConfig.screenHeight,
                width: SizeConfig.screenWidth,
                color: Theme.of(context).primaryColorLight,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.02,
                        ),
                        Text(
                          "signin",
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontSize: SizeConfig.safeBlockHorizontal * 4.8,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                          textScaleFactor: 1.2,
                        ).tr(),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.02,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "by_using_our_services_you_are_agreeing_to_our",
                                  style: TextStyle(
                                      fontStyle: FontStyle.normal,
                                      fontSize: SizeConfig.safeBlockHorizontal * 3,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                  textScaleFactor: 1.2,
                                ).tr(),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {},
                                      child: Text(
                                        "terms",
                                        style: TextStyle(
                                            decoration: TextDecoration.underline,
                                            fontStyle: FontStyle.normal,
                                            fontSize: SizeConfig.safeBlockHorizontal * 3,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                        textScaleFactor: 1.2,
                                      ).tr(),
                                    ),
                                    Text(
                                      "and",
                                      style: TextStyle(
                                          fontStyle: FontStyle.normal,
                                          fontSize: SizeConfig.safeBlockHorizontal * 2.8,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                      textScaleFactor: 1.2,
                                    ).tr(),
                                    InkWell(
                                      onTap: () {},
                                      child: Text(
                                        "privacy_policy",
                                        style: TextStyle(
                                            decoration: TextDecoration.underline,
                                            fontStyle: FontStyle.normal,
                                            fontSize: SizeConfig.safeBlockHorizontal * 3,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                        textScaleFactor: 1.2,
                                      ).tr(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.05,
                        ),
                        Column(
                          children: [
                            Material(
                              color: Colors.white,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Login(),
                                      ));
                                },
                                splashColor: Theme.of(context).primaryColorLight,
                                child: Container(
                                    width: SizeConfig.screenWidth,
                                    height: SizeConfig.screenHeight * 0.052,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.mail_outline,
                                          color: Colors.black,
                                          size: SizeConfig.safeBlockHorizontal * 5.5,
                                        ),
                                        SizedBox(
                                          width: SizeConfig.screenWidth * 0.03,
                                        ),
                                        Text(
                                          "sign_in_with_email",
                                          style: TextStyle(
                                              fontStyle: FontStyle.normal,
                                              fontSize: SizeConfig.safeBlockHorizontal * 3.5,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ).tr(),
                                      ],
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeight * 0.02,
                            ),
                            Material(
                              color: Colors.white,
                              child: InkWell(
                                onTap: () {
                                  signInWithFacebook();
                                },
                                splashColor: Theme.of(context).primaryColorLight,
                                child: Container(
                                    width: SizeConfig.screenWidth,
                                    height: SizeConfig.screenHeight * 0.052,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.facebook,
                                          color: Color.fromRGBO(59, 82, 152, 1),
                                          size: SizeConfig.safeBlockHorizontal * 5,
                                        ),
                                        SizedBox(
                                          width: SizeConfig.screenWidth * 0.03,
                                        ),
                                        Text(
                                          "sign_in_with_facebook",
                                          style: TextStyle(
                                              fontStyle: FontStyle.normal,
                                              fontSize: SizeConfig.safeBlockHorizontal * 3.5,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ).tr(),
                                      ],
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeight * 0.02,
                            ),
                            Material(
                              color: Colors.white,
                              child: InkWell(
                                onTap: () {
                                  _GooglehandleSignIn();
                                },
                                splashColor: Theme.of(context).primaryColorLight,
                                child: Container(
                                  width: SizeConfig.screenWidth,
                                  height: SizeConfig.screenHeight * 0.052,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.google,
                                        color: Color.fromRGBO(66, 133, 244, 1),
                                        size: SizeConfig.safeBlockHorizontal * 5,
                                      ),
                                      SizedBox(
                                        width: SizeConfig.screenWidth * 0.03,
                                      ),
                                      Text(
                                        "sign_in_with_gmail",
                                        style: TextStyle(
                                            fontSize: SizeConfig.safeBlockHorizontal * 3.5, color: Colors.black, fontWeight: FontWeight.w500),
                                      ).tr(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: SizeConfig.safeBlockHorizontal * 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "don't_have_an_account",
                            style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontSize: SizeConfig.safeBlockHorizontal * 3.1,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500),
                            textScaleFactor: 1.2,
                          ).tr(),
                          SizedBox(
                            height: SizeConfig.screenHeight * 5 / 869.56,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUpPage(),
                                  ));
                            },
                            child: Text(
                              "sign_up",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontStyle: FontStyle.normal,
                                  fontSize: SizeConfig.safeBlockHorizontal * 3,
                                  fontWeight: FontWeight.w600),
                              textScaleFactor: 1.3,
                            ).tr(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          is_loading
              ? Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight,
                  color: Color(0xFF0E3311).withOpacity(0.4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(
                        strokeWidth: 1,
                      ),
                    ],
                  ))
              : Container()
        ],
      ),
    );
  }
}
