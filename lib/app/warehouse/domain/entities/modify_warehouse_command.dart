class ModifyWarehouseCommand {
  final String id;
  final String name;
  final String phonenumber;
  final String address;
  final String status;
  final dynamic employeeids;

  ModifyWarehouseCommand({
    required this.id,
    required this.name,
    required this.phonenumber,
    required this.address,
    required this.status,
    required this.employeeids,
  });
  Map<String, dynamic> toJson() {
    return {

      'id': id,
      'name': name,
      'phoneNumber': phonenumber,
      'address': address,
      'status': status,
      'employeeIds': employeeids,
    };
  }

}
