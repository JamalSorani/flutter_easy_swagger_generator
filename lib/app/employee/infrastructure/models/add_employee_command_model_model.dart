class AddEmployeeCommandModel {
  final String fullname;
  final String email;
  final String telegramuserName;
  final String phonenumber;
  final String password;
  final String roleid;

  AddEmployeeCommandModel({
    required this.fullname,
    required this.email,
    required this.telegramuserName,
    required this.phonenumber,
    required this.password,
    required this.roleid,
  });
  factory AddEmployeeCommandModel.fromJson(Map<String,dynamic>json){
  return AddEmployeeCommandModel(

      fullname : json["fullName"],
      email : json["email"],
      telegramuserName : json["telegramUserName"],
      phonenumber : json["phoneNumber"],
      password : json["password"],
      roleid : json["roleId"],
    );
  }

}
