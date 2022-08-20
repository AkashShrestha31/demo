import 'package:connectivity/connectivity.dart';
import 'package:demoproject/Constants/Constants.dart';
import 'package:demoproject/Constants/SizeConfig.dart';
import 'package:demoproject/Model/Authentication/LoginModel/login_model.dart';
import 'package:demoproject/Pages/Authentication/Login/ResetPassword/PasswordReset.dart';
import 'package:demoproject/Provider/API.dart';
import 'package:demoproject/Repository/Repository.dart';
import 'package:demoproject/Utilities/Toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';

import '../../../Bloc/Authentication/Signin/SigninBloc.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  final GlobalKey<FormState> formkey = new GlobalKey<FormState>();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  bool _obscureText = true;
  bool email_val = false;
  bool password_val = false;
  Repository _repository;
  // Toggles the password show status
  void _toggle(bool value) {
    if (value)
      signInBloc.updateObscure(false);
    else
      signInBloc.updateObscure(true);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _repository = Repository();
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return MaterialApp(
      home: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Container(
                height: SizeConfig.screenHeight,
                margin: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 5),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: SizeConfig.screenHeight * 0.43,
                        color: Colors.white,
                        child: Column(
                          children: [
                            Form(
                              key: formkey,
                              child: Column(
                                children: <Widget>[
                                  userNameInput(node: node),
                                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                                  passwordInputField(),
                                ],
                              ),
                            ),
                            SizedBox(height: SizeConfig.screenHeight * 0.03),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => PasswordReset()));
                                  },
                                  child: Text(
                                    "forget_password",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontSize: SizeConfig.safeBlockHorizontal * 3.2,
                                        fontWeight: FontWeight.w500),
                                    textScaleFactor: 1.3,
                                  ).tr(),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeight * 0.04,
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
                                      Connectivity().checkConnectivity().then((value) {
                                        if (value != ConnectivityResult.none) {
                                          signInBloc.updateLoading(true);
                                          FocusScope.of(context).requestFocus(FocusNode());
                                          getDeviceId().then((value) {
                                            FirebaseMessaging.instance.subscribeToTopic(value);
                                            // pushNotificationService.firebaseMessaging.subscribeToTopic(value);
                                            Future<dynamic> tokenmodel = _repository.sendSuccesslogin(
                                                usernameController.text.toLowerCase(), passwordController.text, value, 'custom');
                                            tokenmodel.then((onValue) {
                                              signInBloc.updateLoading(false);
                                              handleResponse(onValue, context);
                                            });
                                          });
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
                                        "login",
                                        style: TextStyle(
                                            fontStyle: FontStyle.normal,
                                            fontSize: SizeConfig.safeBlockHorizontal * 3.5,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ).tr(),
                                    ],
                                  )),
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeight * 0.03,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          StreamBuilder<bool>(
              stream: signInBloc.is_loading,
              initialData: false,
              builder: (context, snapshot) {
                if (snapshot.data == true)
                  return Container(
                    height: SizeConfig.screenHeight,
                    width: SizeConfig.screenWidth,
                    color: Color.fromRGBO(128, 128, 128, 0.5),
                    child: Center(
                      child: CircularProgressIndicator(backgroundColor: Colors.white, strokeWidth: 1),
                    ),
                  );
                return Container();
              })
        ],
      ),
    );
  }

  Widget userNameInput({node}) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete: () => node.nextFocus(),
      textAlign: TextAlign.start,
      controller: usernameController,
      cursorColor: Theme.of(context).primaryColor,
      style: TextStyle(fontStyle: FontStyle.normal, fontSize: SizeConfig.safeBlockHorizontal * 3.4, color: Colors.black, fontWeight: FontWeight.w400),
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
        errorStyle:
            TextStyle(fontStyle: FontStyle.normal, fontSize: SizeConfig.safeBlockHorizontal * 3.4, color: Colors.red, fontWeight: FontWeight.w400),
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
          size: SizeConfig.safeBlockHorizontal * 3.5,
        ),
        filled: true,
        hintStyle: TextStyle(
            fontStyle: FontStyle.normal, fontSize: SizeConfig.safeBlockHorizontal * 3.4, color: Colors.grey[300], fontWeight: FontWeight.w400),
        hintText: "email".tr(),
        fillColor: Colors.white,
      ),
    );
  }

  Widget passwordInputField() {
    return StreamBuilder<bool>(
        stream: signInBloc.obscure_text,
        initialData: true,
        builder: (context, snapshot) {
          return TextFormField(
            textAlign: TextAlign.start,
            textInputAction: TextInputAction.done,
            // onEditingComplete: () => _handleSubmit(),
            obscureText: snapshot.data,
            controller: passwordController,
            style: TextStyle(
                fontStyle: FontStyle.normal, fontSize: SizeConfig.safeBlockHorizontal * 3.4, color: Colors.black, fontWeight: FontWeight.w400),
            cursorColor: Theme.of(context).primaryColor,
            validator: (String value) {
              if (value.isEmpty) {
                return 'please_enter_your_password'.tr();
              }

              if (!RegExp(r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$').hasMatch(value)) {
                return 'password_validation'.tr();
              }

              return null;
            },
            maxLines: 1,
            minLines: 1,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              filled: true,
              prefixIcon: Icon(
                FontAwesomeIcons.lock,
                size: SizeConfig.safeBlockHorizontal * 3.5,
              ),
              suffixIcon: InkWell(
                onTap: () {
                  _toggle(snapshot.data);
                },
                child: snapshot.data
                    ? Icon(
                        FontAwesomeIcons.eyeSlash,
                        size: SizeConfig.safeBlockHorizontal * 3.5,
                      )
                    : Icon(
                        FontAwesomeIcons.eye,
                        size: SizeConfig.safeBlockHorizontal * 3.5,
                      ),
              ),
              hintStyle: TextStyle(
                  fontStyle: FontStyle.normal, fontSize: SizeConfig.safeBlockHorizontal * 3.4, color: Colors.grey[300], fontWeight: FontWeight.w400),
              hintText: "password".tr(),
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
                  fontStyle: FontStyle.normal, fontSize: SizeConfig.safeBlockHorizontal * 3.4, color: Colors.red, fontWeight: FontWeight.w400),
              isDense: true,
              contentPadding: EdgeInsets.fromLTRB(SizeConfig.safeBlockHorizontal * 4, SizeConfig.safeBlockHorizontal * 2,
                  SizeConfig.safeBlockHorizontal * 4, SizeConfig.safeBlockHorizontal * 2),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(SizeConfig.safeBlockHorizontal * 2),
                ),
              ),
              fillColor: Colors.white,
            ),
          );
        });
  }

  void handleResponse(LoginModel onValue, BuildContext context) {
    switch (onValue.statusCode) {
      case 202:
        Toast.show(onValue.message, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM, backgroundColor: Theme.of(context).primaryColor);
        final box = GetStorage();
        box.write('token', onValue.accessToken);
        box.write('userinfo', onValue.userInfo.toJson());
        usernameController.clear();
        passwordController.clear();
        api.init();

        break;
      case 200:
        Toast.show(onValue.message, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM, backgroundColor: Theme.of(context).primaryColor);
        break;
      case 401:
        Toast.show(onValue.message, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM, backgroundColor: Theme.of(context).primaryColor);
        break;
    }
  }
}
