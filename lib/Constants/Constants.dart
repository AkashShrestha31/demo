import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'SizeConfig.dart';

const server = 'https://server.pocketexam.co';
// const server = 'http://192.168.1.4:80';
List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sept', 'Oct', 'Nov', 'Dec'];
List<String> week = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
const institute = 'driving-license';
var kTextFieldDecoration = InputDecoration(
  hintText: 'Enter your email',
  contentPadding: EdgeInsets.fromLTRB(
      SizeConfig.safeBlockHorizontal * 4, SizeConfig.safeBlockHorizontal * 3, SizeConfig.safeBlockHorizontal * 4, SizeConfig.safeBlockHorizontal * 3),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(SizeConfig.safeBlockHorizontal * 2),
    ),
  ),
);
const kTextStyle = TextStyle(color: Colors.white, fontSize: 15, decoration: TextDecoration.underline, fontWeight: FontWeight.w700);
const hintTextStyle = TextStyle(color: Color.fromRGBO(187, 187, 187, 1));
Future<String> getDeviceId() async {
  final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
  if (Platform.isAndroid) {
    var build = await deviceInfoPlugin.androidInfo;
    // deviceName = build.model;
    // deviceVersion = build.version.toString();
    return build.androidId; //UUID for Android
    // pushNotificationService.firebaseMessaging.subscribeToTopic(identifier);

  }
}

String replaceNepaliNumber(String input) {
  var value = [];
  for (int i = 0; i < input.length; i++) {
    value.add(input[i].tr());
  }

  return value.join("");
}

String get_language() {
  var box = GetStorage();
  if (box.read('language') == 'English') {
    return 'en';
  } else if (box.read('language') == 'नेपाली') {
    return 'ne';
  }
}
