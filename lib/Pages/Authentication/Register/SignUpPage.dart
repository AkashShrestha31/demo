import 'package:demoproject/Bloc/Authentication/Signup/SignupBloc.dart';
import 'package:demoproject/Constants/SizeConfig.dart';
import 'package:demoproject/Pages/Authentication/Register/Components/CircularSpinner.dart';
import 'package:demoproject/Pages/Authentication/Register/Components/SignUpPage/UserInput.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: true,
            appBar: new AppBar(
              title: Text(
                "create_account",
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
            body: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockHorizontal * 4.5),
                  child: Container(height: SizeConfig.screenHeight, child: Center(child: UserInput())),
                )
              ],
            ),
          ),
          StreamBuilder<bool>(
              initialData: false,
              stream: signUpBloc.is_loading,
              builder: (context, snapshot) {
                return CircularSpinner(
                  is_loading: snapshot.data,
                );
              })
        ],
      ),
    );
  }
}
