import 'package:demoproject/Model/Authentication/SignupModel/SignupResponseModel.dart';
import 'package:demoproject/Provider/Authentication/ChangePasswordProvider.dart';
import 'package:demoproject/Provider/Authentication/EmailVerificationProvider.dart';
import 'package:demoproject/Provider/Authentication/LoginProvider.dart';
import 'package:demoproject/Provider/Authentication/PasswordResetProvider.dart';
import 'package:demoproject/Provider/Authentication/ResendEmailProvider.dart';
import 'package:demoproject/Provider/Authentication/ResetEmailProvider.dart';
import 'package:demoproject/Provider/Authentication/SignupProvider.dart';

class Repository {
  LoginUser loginUser = LoginUser();
  Future<dynamic> sendSuccesslogin(String email, String password, String deviceid, String type) {
    return loginUser.loginUserInfo(email, password, deviceid, type);
  }

  EmailVerificationProvider _emialVerify = EmailVerificationProvider();
  Future<SignupResponseModel> getEmailResponse(var body) {
    return _emialVerify.verifyEmail(body);
  }

  ResendEmailProvider _resendEmail = ResendEmailProvider();
  Future<SignupResponseModel> getReMailResponse(String body) {
    //from resendEmail
    return _resendEmail.rePostEmail(body); //from provider
  }

  ResetEmailProvider _resetEmail = ResetEmailProvider();
  Future<SignupResponseModel> resetMailResponse(String body) {
    //from resendEmail
    return _resetEmail.resetPostEmail(body); //from provider
  }

  PasswordResetProvider _resetPassword = PasswordResetProvider();
  Future<SignupResponseModel> getPassResetResponse(var token, var body) {
    return _resetPassword.resetPassword(token, body);
  }

  SignupProvider _signUp = SignupProvider();
  Future<SignupResponseModel> getSignUpResponse(var body) {
    return _signUp.postData(body);
  }

  ChangePasswordProvider _changePasswordProvider = ChangePasswordProvider();
  Future<SignupResponseModel> changePassword(String current, String newPass) {
    return _changePasswordProvider.changePassword(current, newPass);
  }
}

Repository repository = Repository();
