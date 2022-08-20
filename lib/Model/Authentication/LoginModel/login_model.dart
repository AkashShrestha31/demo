// {
// "status_code": 202,
// "message": "Logged in successfully !!!",
// "access_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjI3MzA2NzQwLCJqdGkiOiI4NjUwYmZiZTBhNzk0YjY4YTM3NWE1NTA1MjkzYjBlYSIsInVzZXJfaWQiOiI0MDI5OTQwNC0wYWU0LTRkYjQtOWMwNy00OTIwYTU5NDE2ODIifQ.iWvETBmWfflXmizcmveYeQqqe2hqT4fq13bAF3QXIY4",
// "refresh_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTYyOTg5ODc0MCwianRpIjoiYTM4MGYyZmQ3OWRiNDFiOGIxNmQ0OTYzMmJjOTE5YzUiLCJ1c2VyX2lkIjoiNDAyOTk0MDQtMGFlNC00ZGI0LTljMDctNDkyMGE1OTQxNjgyIn0.c-yPIOd901jeC-ZlGLaqr7OnCd3_8bb1-Q165SS4LkA",
// "user_info": {
// "username": "bikram rai",
// "email": "bikramrai@gmail.com",
// "image_uri": null
// }
// }

// ignore: camel_case_types
class LoginModel {
  int _statusCode;
  String _message;
  String _accessToken;
  String _refreshToken;
  UserInfo _userInfo;

  LoginModel({int statusCode, String message, String accessToken, String refreshToken, UserInfo userInfo}) {
    this._statusCode = statusCode;
    this._message = message;
    this._accessToken = accessToken;
    this._refreshToken = refreshToken;
    this._userInfo = userInfo;
  }

  int get statusCode => _statusCode;
  set statusCode(int statusCode) => _statusCode = statusCode;
  String get message => _message;
  set message(String message) => _message = message;
  String get accessToken => _accessToken;
  set accessToken(String accessToken) => _accessToken = accessToken;
  String get refreshToken => _refreshToken;
  set refreshToken(String refreshToken) => _refreshToken = refreshToken;
  UserInfo get userInfo => _userInfo;
  set userInfo(UserInfo userInfo) => _userInfo = userInfo;

  LoginModel.fromJson(Map<String, dynamic> json) {
    _statusCode = json['status_code'];
    _message = json['message'];
    _accessToken = json['access_token'];
    _refreshToken = json['refresh_token'];
    _userInfo = json['user_info'] != null ? new UserInfo.fromJson(json['user_info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this._statusCode;
    data['message'] = this._message;
    data['access_token'] = this._accessToken;
    data['refresh_token'] = this._refreshToken;
    if (this._userInfo != null) {
      data['user_info'] = this._userInfo.toJson();
    }
    return data;
  }
}

class UserInfo {
  String _username;
  String _email;
  String _imageUri;

  UserInfo({String username, String email, String imageUri}) {
    this._username = username;
    this._email = email;
    this._imageUri = imageUri;
  }

  String get username => _username;
  set username(String username) => _username = username;
  String get email => _email;
  set email(String email) => _email = email;
  String get imageUri => _imageUri;
  set imageUri(String imageUri) => _imageUri = imageUri;

  UserInfo.fromJson(Map<String, dynamic> json) {
    _username = json['username'];
    _email = json['email'];
    _imageUri = json['image_uri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this._username;
    data['email'] = this._email;
    data['image_uri'] = this._imageUri;
    return data;
  }
}
