class ForgetPasswordCommandModel {
  final String email;

  ForgetPasswordCommandModel({
    required this.email,
  });
  factory ForgetPasswordCommandModel.fromJson(Map<String,dynamic>json){
  return ForgetPasswordCommandModel(

      email : json["email"],
    );
  }

}
