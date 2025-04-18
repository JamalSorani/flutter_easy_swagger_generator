class AddSalesWindowCommand {
  final String name;
  final String address;
  final List<String> employeeids;

  AddSalesWindowCommand({
    required this.name,
    required this.address,
    required this.employeeids,
  });
  Map<String, dynamic> toJson() {
    return {

      'name': name,
      'address': address,
      'employeeIds': employeeids,
    };
  }

}
