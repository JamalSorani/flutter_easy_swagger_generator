class ModifyMyProfileCommandModel {
  final String fullname;
  final String email;
  final String phonenumber;

  ModifyMyProfileCommandModel({
    required this.fullname,
    required this.email,
    required this.phonenumber,
  });
  factory ModifyMyProfileCommandModel.fromJson(Map<String,dynamic>json){
  return ModifyMyProfileCommandModel(

      fullname : json["fullName"],
      email : json["email"],
      phonenumber : json["phoneNumber"],
    );
  }

}
