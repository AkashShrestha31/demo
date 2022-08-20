import 'dart:convert';

import 'package:demoproject/Constants/Constants.dart';
import 'package:demoproject/Model/Authentication/SignupModel/SignupResponseModel.dart';
import 'package:http/http.dart' as http;

class ResendEmailProvider {
  final _baseUrl = server + '/api/student/resend_email_confirmation/';

  Future<SignupResponseModel> rePostEmail(var body) async {
    var data = {"email": body};

    http.Response response = await http.post(Uri.parse(_baseUrl), body: json.encode(data), headers: {"Content-Type": "application/json"});

    return SignupResponseModel.fromJson(json.decode(response.body));
  }
}
