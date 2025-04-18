class LogInEmployeeCommandModel {
  final String email;
  final String password;
  final String devicetoken;

  LogInEmployeeCommandModel({
    required this.email,
    required this.password,
    required this.devicetoken,
  });
  Map<String, dynamic> toJson() {
    return {

      'email': email,
      'password': password,
      'deviceToken': devicetoken,
    };
  }

}
