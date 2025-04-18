class ExportEmployeesToExcelQuery {
  final List<String> employeeids;

  ExportEmployeesToExcelQuery({
    required this.employeeids,
  });
  Map<String, dynamic> toJson() {
    return {

      'employeeIds': employeeids,
    };
  }

}
