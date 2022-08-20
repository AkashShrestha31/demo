import 'package:demoproject/Constants/Constants.dart';
import 'package:demoproject/Model/Authentication/SignupModel/SignupResponseModel.dart';
import 'package:dio/dio.dart';

class EmailVerificationProvider {
  Dio dio = Dio();

  final _baseUrl = server + '/api/student/verify';

  Future<SignupResponseModel> verifyEmail(token) async {
    var query = {'token': token};
    try {
      final response = await dio.put(_baseUrl, queryParameters: query, options: Options(headers: {"Accept": "application/json"}));

      return SignupResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      return SignupResponseModel.fromJson(e.response.data);
    }
  }
}
