class AddEmployeeCommandParam {
  final String fullname;
  final String email;
  final String telegramuserName;
  final String phonenumber;
  final String password;
  final String roleid;

  AddEmployeeCommandParam({
    required this.fullname,
    required this.email,
    required this.telegramuserName,
    required this.phonenumber,
    required this.password,
    required this.roleid,
  });
  Map<String, dynamic> toJson() {
    return {

      'fullName': fullname,
      'email': email,
      'telegramUserName': telegramuserName,
      'phoneNumber': phonenumber,
      'password': password,
      'roleId': roleid,
    };
  }

}
