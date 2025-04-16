class AddWarehouseCommand {
  final String name;
  final dynamic employeeids;
  final String phonenumber;
  final String address;

  AddWarehouseCommand({
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
