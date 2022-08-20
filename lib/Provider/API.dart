import 'package:dio/dio.dart';

class API {
  Dio dio = new Dio();
  var header = {"content-type": "application/json", "Accept": "application/json", "Authorization": "Bearer "};
  init() {
    header = {"content-type": "application/json", "Accept": "application/json", "Authorization": "Bearer "};
  }
}

API api = API();
