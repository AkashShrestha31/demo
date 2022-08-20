import 'package:connectivity/connectivity.dart';
import 'package:demoproject/Bloc/Authentication/Signup/SignupBloc.dart';
import 'package:demoproject/Constants/Constants.dart';
import 'package:demoproject/Constants/SizeConfig.dart';
import 'package:demoproject/Model/Authentication/SignupModel/SignupResponseModel.dart';
import 'package:demoproject/Repository/Repository.dart';
import 'package:demoproject/Utilities/Toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../ResponeCheck.dart';

class UserInput extends StatefulWidget {
  @override
  UserInputState createState() => UserInputState();
}

class UserInputState extends State<UserInput> {
  final GlobalKey<FormState> formkey = new GlobalKey<FormState>();

  TextEditingController firstname = new TextEditingController();
  TextEditingController lastname = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController confirmPassword = new TextEditingController();
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
    return SingleChildScrollView(
      child: Form(
        key: formkey,
        child: Column(
          children: [
            TextFormField(
              controller: firstname,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              maxLines: 1,
              //  maxLength: 10,
              minLines: 1,
              decoration: InputDecoration(
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
                hintStyle: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: SizeConfig.safeBlockHorizontal * 3.4,
                    color: Colors.grey[300],
                    fontWeight: FontWeight.w400),
                fillColor: Colors.white,
                filled: true,
                hintText: 'first_name'.tr(),
                prefixIcon: Icon(
                  FontAwesomeIcons.user,
                  size: SizeConfig.safeBlockHorizontal * 4,
                ),
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'please_enter_your_first_name'.tr();
                }
                return null;
              },
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 3.4,
            ),
            TextFormField(
              controller: lastname,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              maxLines: 1,
              //  maxLength: 10,
              minLines: 1,
              decoration: kTextFieldDecoration.copyWith(
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
                  hintStyle: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontSize: SizeConfig.safeBlockHorizontal * 3.4,
                      color: Colors.grey[300],
                      fontWeight: FontWeight.w400),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'last_name'.tr(),
                  prefixIcon: Icon(
                    FontAwesomeIcons.user,
                    size: SizeConfig.safeBlockHorizontal * 3.4,
                  )),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'please_enter_your_last_name'.tr();
                }
                return null;
              },
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 3.4,
            ),
            TextFormField(
              controller: emailController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,

              maxLines: 1,
              //  maxLength: 10,
              minLines: 1,
              decoration: kTextFieldDecoration.copyWith(
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
                hintStyle: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: SizeConfig.safeBlockHorizontal * 3.4,
                    color: Colors.grey[300],
                    fontWeight: FontWeight.w400),
                fillColor: Colors.white,
                filled: true,
                hintText: 'email'.tr(),
                prefixIcon: Icon(FontAwesomeIcons.envelope, size: SizeConfig.safeBlockHorizontal * 4),
              ),
              validator: (value) => EmailValidator.validate(value) ? null : "Please enter a valid email",
            ),

            SizedBox(
              height: SizeConfig.blockSizeVertical * 3.4,
            ),
            TextFormField(
              controller: phone,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
              maxLines: 1,
              maxLength: 10,
              minLines: 1,
              decoration: InputDecoration(
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
                  hintStyle: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontSize: SizeConfig.safeBlockHorizontal * 3.4,
                      color: Colors.grey[300],
                      fontWeight: FontWeight.w400),
                  filled: true,
                  fillColor: Colors.white,
                  counterText: "",
                  hintText: 'e.g: 9805360520',
                  prefixIcon: Icon(FontAwesomeIcons.phoneAlt, size: SizeConfig.safeBlockHorizontal * 4)),
              validator: (String value) {
                if (value.toString().isEmpty) {
                  return 'please_enter_your_phone_no'.tr();
                }

                return null;
              },
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 3.4,
            ),
            TextFormField(
              controller: password,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              obscureText: _ishiddenPassword,
              maxLines: 1,
              //  maxLength: 10,
              minLines: 1,
              decoration: kTextFieldDecoration.copyWith(
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
                  hintStyle: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontSize: SizeConfig.safeBlockHorizontal * 3.4,
                      color: Colors.grey[300],
                      fontWeight: FontWeight.w400),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'password'.tr(),
                  prefixIcon: Icon(FontAwesomeIcons.lock, size: SizeConfig.safeBlockHorizontal * 4),
                  suffixIcon: InkWell(
                    onTap: () {
                      togglePassword();
                    },
                    child: _ishiddenPassword
                        ? Icon(FontAwesomeIcons.eyeSlash, size: SizeConfig.safeBlockHorizontal * 3.3)
                        : Icon(FontAwesomeIcons.eye, size: SizeConfig.safeBlockHorizontal * 3.3),
                  )),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'please_enter_your_password'.tr();
                }

                if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$').hasMatch(value)) {
                  return 'password_validation'.tr();
                }

                return null;
              },
            ),

            SizedBox(
              height: SizeConfig.blockSizeVertical * 4,
            ),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text(
            //       'Already Have an Account ?  ',
            //       style: TextStyle(fontWeight: FontWeight.w400, color: Colors.grey),
            //       textScaleFactor: 1.2,
            //     ),
            //     InkWell(
            //       onTap: () {
            //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
            //       },
            //       child: Text(
            //         "Sign in",
            //         style: TextStyle(
            //           fontWeight: FontWeight.w500,
            //           decoration: TextDecoration.underline,
            //         ),
            //         textScaleFactor: 1.3,
            //       ),
            //     ),
            //   ],
            // ),
            // LastPart signup signin
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
                          signUpBloc.updateLoading(true);

                          var body = {
                            "email": emailController.text,
                            "password": password.text,
                            "profile": {
                              "first_name": firstname.text,
                              "last_name": lastname.text,
                              "phone": phone.text,
                              "image_uri": null,
                              "device_identifier": "98##11",
                              "login_type": "custom"
                            }
                          };

                          SignupResponseModel response = await repository.getSignUpResponse(body);
                          ResponseCheck().responseCheck(context, response, emailController.text);
                        } else {
                          Toast.show("check_internet".tr(), context,
                              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM, backgroundColor: Theme.of(context).primaryColor);
                        }
                      });
                      //dictionary

                    }
                  },
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text(
                        "sign_up",
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
    );
  }
}
