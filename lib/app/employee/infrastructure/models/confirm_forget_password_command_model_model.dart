class ConfirmForgetPasswordCommandModel {
  final String email;
  final String code;

  ConfirmForgetPasswordCommandModel({
    required this.email,
    required this.code,
  });
  factory ConfirmForgetPasswordCommandModel.fromJson(Map<String,dynamic>json){
  return ConfirmForgetPasswordCommandModel(

      email : json["email"],
      code : json["code"],
    );
  }

}
