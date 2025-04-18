class ModifyCustomerCommandModel {
  final String id;
  final String fullname;
  final String phonenumber;
  final String company;

  ModifyCustomerCommandModel({
    required this.id,
    required this.fullname,
    required this.phonenumber,
    required this.company,
  });
  factory ModifyCustomerCommandModel.fromJson(Map<String,dynamic>json){
  return ModifyCustomerCommandModel(

      id : json["id"],
      fullname : json["fullName"],
      phonenumber : json["phoneNumber"],
      company : json["company"],
    );
  }

}
