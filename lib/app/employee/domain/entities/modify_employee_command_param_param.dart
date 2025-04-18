class ModifyEmployeeCommandParam {
  final String id;
  final String fullname;
  final String email;
  final String phonenumber;
  final String telegramuserName;
  final String password;
  final String roleid;
  final String status;

  ModifyEmployeeCommandParam({
    required this.id,
    required this.fullname,
    required this.email,
    required this.phonenumber,
    required this.telegramuserName,
    required this.password,
    required this.roleid,
    required this.status,
  });
  Map<String, dynamic> toJson() {
    return {

      'id': id,
      'fullName': fullname,
      'email': email,
      'phoneNumber': phonenumber,
      'telegramUserName': telegramuserName,
      'password': password,
      'roleId': roleid,
      'status': status,
    };
  }

}
