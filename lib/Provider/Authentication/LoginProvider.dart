import 'dart:async';

import 'package:demoproject/Constants/Constants.dart';
import 'package:demoproject/Model/Authentication/LoginModel/login_model.dart';
import 'package:dio/dio.dart';

class LoginUser {
  final _baseUrl = server + '/api/student/login/';

  Future<dynamic> loginUserInfo(String email, String password, String deviceid, String type) async {
    Dio dio = new Dio();
    var formData = {'email': email, 'password': password, 'device_id': deviceid, 'type': type};
    try {
      var res = await dio.post(_baseUrl, data: FormData.fromMap(formData));
      return LoginModel.fromJson(res.data);
    } on DioError catch (e) {
      return LoginModel.fromJson(e.response.data);
    }
  }
}
