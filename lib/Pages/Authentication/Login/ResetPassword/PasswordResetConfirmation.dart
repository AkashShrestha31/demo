import 'package:connectivity/connectivity.dart';
import 'package:demoproject/Constants/SizeConfig.dart';
import 'package:demoproject/Model/Authentication/SignupModel/SignupResponseModel.dart';
import 'package:demoproject/Pages/Authentication/Login/Login.dart';
import 'package:demoproject/Pages/Authentication/Register/Components/CircularSpinner.dart';
import 'package:demoproject/Repository/Repository.dart';
import 'package:demoproject/Utilities/Toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PasswordResetConfirmation extends StatefulWidget {
  @override
  _PasswordResetConfirmationState createState() => _PasswordResetConfirmationState();
}

class _PasswordResetConfirmationState extends State<PasswordResetConfirmation> {
  bool is_loading = false;
  TextEditingController tokencontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  TextEditingController repeatpasswordcontroller = new TextEditingController();

  final GlobalKey<FormState> formkey = new GlobalKey<FormState>();

  bool _ishiddenPassword = true;
  bool _isConfirmPasswordHidden = true;

  void toggleConfirmPassword() {
    setState(() {
      _isConfirmPasswordHidden = !_isConfirmPasswordHidden;
    });
  }

  void togglePassword() {
    setState(() {
      _ishiddenPassword = !_ishiddenPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: new AppBar(
            title: Text(
              "Change Password",
              style: TextStyle(
                  color: Colors.black, fontStyle: FontStyle.normal, fontSize: SizeConfig.safeBlockHorizontal * 4, fontWeight: FontWeight.w500),
            ),
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
          body: SingleChildScrollView(
              child: Form(
            key: formkey,
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 5),
                child: Column(
                  children: [
                    SizedBox(
                      height: SizeConfig.safeBlockHorizontal * 4,
                    ),
                    Text(
                      "We've emailed you instructions for setting your password, if an account exists with the email you entered.You should receive them shortly.",
                      style: TextStyle(fontStyle: FontStyle.normal, fontSize: SizeConfig.safeBlockHorizontal * 3.2, fontWeight: FontWeight.w400),
                      textScaleFactor: 1.3,
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockHorizontal * 8,
                    ),
                    Image.asset(
                      "assets/Images/change-pw.png",
                      scale: SizeConfig.safeBlockHorizontal * 0.6,
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockHorizontal * 8,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.start,
                      controller: tokencontroller,
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
                          FontAwesomeIcons.key,
                          size: SizeConfig.safeBlockHorizontal * 3.5,
                        ),
                        filled: true,
                        hintStyle: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: SizeConfig.safeBlockHorizontal * 3.4,
                            color: Colors.grey[300],
                            fontWeight: FontWeight.w400),
                        hintText: "Enter token",
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockHorizontal * 5,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.start,
                      controller: passwordcontroller,
                      cursorColor: Theme.of(context).primaryColor,
                      style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontSize: SizeConfig.safeBlockHorizontal * 3.4,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                      onTap: () {},
                      maxLines: 1,
                      minLines: 1,
                      obscureText: _ishiddenPassword,
                      decoration: new InputDecoration(
                        errorMaxLines: 4,
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
                          FontAwesomeIcons.lock,
                          size: SizeConfig.safeBlockHorizontal * 3.5,
                        ),
                        suffixIcon: InkWell(
                          onTap: togglePassword,
                          child: _ishiddenPassword
                              ? Icon(FontAwesomeIcons.eyeSlash, size: SizeConfig.safeBlockHorizontal * 3.5)
                              : Icon(FontAwesomeIcons.eye, size: SizeConfig.safeBlockHorizontal * 3.5),
                        ),
                        filled: true,
                        hintStyle: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: SizeConfig.safeBlockHorizontal * 3.4,
                            color: Colors.grey[300],
                            fontWeight: FontWeight.w400),
                        hintText: "New Password",
                        fillColor: Colors.white,
                      ),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Enter passwrod here!';
                        }

                        if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$').hasMatch(value)) {
                          return 'Include one capital letter and enter upto 8 lengths.';
                        }

                        return null;
                      },
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockHorizontal * 5,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      textAlign: TextAlign.start,
                      controller: repeatpasswordcontroller,
                      cursorColor: Theme.of(context).primaryColor,
                      style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontSize: SizeConfig.safeBlockHorizontal * 3.4,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                      onTap: () {},
                      maxLines: 1,
                      minLines: 1,
                      obscureText: _isConfirmPasswordHidden,
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
                          FontAwesomeIcons.lock,
                          size: SizeConfig.safeBlockHorizontal * 3.5,
                        ),
                        suffixIcon: InkWell(
                          onTap: toggleConfirmPassword,
                          child: _isConfirmPasswordHidden
                              ? Icon(
                                  FontAwesomeIcons.eyeSlash,
                                  size: SizeConfig.safeBlockHorizontal * 3.5,
                                )
                              : Icon(
                                  FontAwesomeIcons.eye,
                                  size: SizeConfig.safeBlockHorizontal * 3.5,
                                ),
                        ),
                        filled: true,
                        hintStyle: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: SizeConfig.safeBlockHorizontal * 3.4,
                            color: Colors.grey[300],
                            fontWeight: FontWeight.w400),
                        hintText: "Re-Enter New Password",
                        fillColor: Colors.white,
                      ),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Re-enter New password';
                        }
                        if (passwordcontroller.text != repeatpasswordcontroller.text) {
                          return 'Password do not match';
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
                          onPressed: () {
                            if (formkey.currentState.validate()) {
                              Connectivity().checkConnectivity().then((value) async {
                                if (value != ConnectivityResult.none) {
                                  setState(() {
                                    is_loading = true;
                                  });

                                  var body = passwordcontroller.text;
                                  SignupResponseModel response = await repository.getPassResetResponse(tokencontroller.text, body);
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
                                        return Login();
                                      }));

                                      break;
                                    case 404:
                                      Toast.show(response.message, context,
                                          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM, backgroundColor: Theme.of(context).primaryColor);
                                      break;
                                    case 400:
                                      Toast.show(response.message, context,
                                          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM, backgroundColor: Theme.of(context).primaryColor);
                                      break;
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
                                "CHANGE PASSWORD",
                                style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontSize: SizeConfig.safeBlockHorizontal * 3.5,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ),
          )),
        ),
        CircularSpinner(is_loading: is_loading)
      ],
    );
  }
}
