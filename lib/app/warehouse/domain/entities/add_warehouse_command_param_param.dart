class AddWarehouseCommandParam {
  final String name;
  final List<String> employeeids;
  final String phonenumber;
  final String address;

  AddWarehouseCommandParam({
    required this.name,
    required this.employeeids,
    required this.phonenumber,
    required this.address,
  });
  Map<String, dynamic> toJson() {
    return {

      'name': name,
      'employeeIds': employeeids,
      'phoneNumber': phonenumber,
      'address': address,
    };
  }

}
