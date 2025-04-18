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
  factory ResetPasswordCommandModel.fromJson(Map<String,dynamic>json){
  return ResetPasswordCommandModel(

      code : json["code"],
      email : json["email"],
      newpassword : json["newPassword"],
      confirmpassword : json["confirmPassword"],
      devicetoken : json["deviceToken"],
    );
  }

}
