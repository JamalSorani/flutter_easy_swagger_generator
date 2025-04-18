class ModifyMyProfileCommandParam {
  final String fullname;
  final String email;
  final String phonenumber;

  ModifyMyProfileCommandParam({
    required this.fullname,
    required this.email,
    required this.phonenumber,
  });
  Map<String, dynamic> toJson() {
    return {

      'fullName': fullname,
      'email': email,
      'phoneNumber': phonenumber,
    };
  }

}
