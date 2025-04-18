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
  Map<String, dynamic> toJson() {
    return {

      'id': id,
      'fullName': fullname,
      'phoneNumber': phonenumber,
      'company': company,
    };
  }

}
