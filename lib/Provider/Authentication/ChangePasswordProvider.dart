import 'package:demoproject/Constants/Constants.dart';
import 'package:demoproject/Model/Authentication/SignupModel/SignupResponseModel.dart';
import 'package:demoproject/Provider/API.dart';
import 'package:dio/dio.dart';

class ChangePasswordProvider {
  final _baseUrl = server + '/api/student/password/change/';

  Future<SignupResponseModel> changePassword(String current, String newPass) async {
    FormData formData = FormData.fromMap({'old_password': current, 'new_password': newPass});

    try {
      final response = await api.dio.put(
        _baseUrl,
        data: formData,
        options: Options(headers: api.header, contentType: "multipart/form-data"),
      );

      return SignupResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      return SignupResponseModel.fromJson(e.response.data);
    }
  }
}
