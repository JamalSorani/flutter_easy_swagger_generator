class ModifyEmployeeCommandModel {
  final String id;
  final String fullname;
  final String email;
  final String phonenumber;
  final String telegramuserName;
  final String password;
  final String roleid;
  final String status;

  ModifyEmployeeCommandModel({
    required this.id,
    required this.fullname,
    required this.email,
    required this.phonenumber,
    required this.telegramuserName,
    required this.password,
    required this.roleid,
    required this.status,
  });
  factory ModifyEmployeeCommandModel.fromJson(Map<String,dynamic>json){
  return ModifyEmployeeCommandModel(

      id : json["id"],
      fullname : json["fullName"],
      email : json["email"],
      phonenumber : json["phoneNumber"],
      telegramuserName : json["telegramUserName"],
      password : json["password"],
      roleid : json["roleId"],
      status : json["status"],
    );
  }

}
