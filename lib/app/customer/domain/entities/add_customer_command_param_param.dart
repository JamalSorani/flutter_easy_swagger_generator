class AddCustomerCommandParam {
  final String fullname;
  final String phonenumber;
  final String company;

  AddCustomerCommandParam({
    required this.fullname,
    required this.phonenumber,
    required this.company,
  });
  Map<String, dynamic> toJson() {
    return {

      'fullName': fullname,
      'phoneNumber': phonenumber,
      'company': company,
    };
  }

}
