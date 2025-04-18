class AddCustomerCommandModel {
  final String fullname;
  final String phonenumber;
  final String company;

  AddCustomerCommandModel({
    required this.fullname,
    required this.phonenumber,
    required this.company,
  });
  factory AddCustomerCommandModel.fromJson(Map<String,dynamic>json){
  return AddCustomerCommandModel(

      fullname : json["fullName"],
      phonenumber : json["phoneNumber"],
      company : json["company"],
    );
  }

}
