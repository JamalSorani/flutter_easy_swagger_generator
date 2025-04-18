class ModifyMyPasswordCommandModel {
  final String oldpassword;
  final String newpassword;
  final String confirmpassword;

  ModifyMyPasswordCommandModel({
    required this.oldpassword,
    required this.newpassword,
    required this.confirmpassword,
  });
  Map<String, dynamic> toJson() {
    return {

      'oldPassword': oldpassword,
      'newPassword': newpassword,
      'confirmPassword': confirmpassword,
    };
  }

}
