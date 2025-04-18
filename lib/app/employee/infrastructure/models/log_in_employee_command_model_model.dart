class LogInEmployeeCommandModel {
  final String email;
  final String password;
  final String devicetoken;

  LogInEmployeeCommandModel({
    required this.email,
    required this.password,
    required this.devicetoken,
  });
  factory LogInEmployeeCommandModel.fromJson(Map<String,dynamic>json){
  return LogInEmployeeCommandModel(

      email : json["email"],
      password : json["password"],
      devicetoken : json["deviceToken"],
    );
  }

}
