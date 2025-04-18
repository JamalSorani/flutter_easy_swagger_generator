class ModifySalesWindowCommand {
  final String id;
  final String name;
  final String address;
  final String status;
  final List<String> employeeids;

  ModifySalesWindowCommand({
    required this.id,
    required this.name,
    required this.address,
    required this.status,
    required this.employeeids,
  });
  Map<String, dynamic> toJson() {
    return {

      'id': id,
      'name': name,
      'address': address,
      'status': status,
      'employeeIds': employeeids,
    };
  }

}
