class ModifyMyProfileCommandModel {
  final String fullname;
  final String email;
  final String phonenumber;

  ModifyMyProfileCommandModel({
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
