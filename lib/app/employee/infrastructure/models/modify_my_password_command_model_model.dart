class ModifyMyPasswordCommandModel {
  final String oldpassword;
  final String newpassword;
  final String confirmpassword;

  ModifyMyPasswordCommandModel({
    required this.oldpassword,
    required this.newpassword,
    required this.confirmpassword,
  });
  factory ModifyMyPasswordCommandModel.fromJson(Map<String,dynamic>json){
  return ModifyMyPasswordCommandModel(

      oldpassword : json["oldPassword"],
      newpassword : json["newPassword"],
      confirmpassword : json["confirmPassword"],
    );
  }

}
