import 'dart:convert';

import 'package:demoproject/Bloc/Authentication/Signup/SignupBloc.dart';
import 'package:demoproject/Constants/Constants.dart';
import 'package:demoproject/Model/Authentication/SignupModel/SignupResponseModel.dart';
import 'package:http/http.dart' as http;

class SignupProvider {
  final _baseUrl = server + '/api/student/register/';

  Future<SignupResponseModel> postData(var body) async {
    http.Response response = await http.post(Uri.parse(_baseUrl), body: json.encode(body), headers: {"Content-Type": "application/json"});
    signUpBloc.updateLoading(false);
    return SignupResponseModel.fromJson(json.decode(response.body));
  }
}
