class ResetPasswordCommandModel {
  final String code;
  final String email;
  final String newpassword;
  final String confirmpassword;
  final String devicetoken;

  ResetPasswordCommandModel({
    required this.code,
    required this.email,
    required this.newpassword,
    required this.confirmpassword,
    required this.devicetoken,
  });
  Map<String, dynamic> toJson() {
    return {

      'code': code,
      'email': email,
      'newPassword': newpassword,
      'confirmPassword': confirmpassword,
      'deviceToken': devicetoken,
    };
  }

}
