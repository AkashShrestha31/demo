import 'dart:convert';

import 'package:demoproject/Constants/Constants.dart';
import 'package:demoproject/Model/Authentication/SignupModel/SignupResponseModel.dart';
import 'package:dio/dio.dart';

class PasswordResetProvider {
  Dio dio = Dio();

  final _baseUrl = server + '/api/student/reset';

  Future<SignupResponseModel> resetPassword(token, body) async {
    var query = {'token': token};
    FormData formData = FormData.fromMap({'password': body});

    try {
      final response = await dio.put(
        _baseUrl,
        queryParameters: query,
        data: formData,
        options: Options(headers: {"Accept": "application/json"}, contentType: "multipart/form-data"),
      );

      return SignupResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      return SignupResponseModel.fromJson(e.response.data);
    }
  }
}
