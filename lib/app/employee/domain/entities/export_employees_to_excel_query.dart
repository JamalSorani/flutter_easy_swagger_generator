class ExportEmployeesToExcelQuery {
  final dynamic employeeids;

  ExportEmployeesToExcelQuery({
    required this.employeeids,
  });
  Map<String, dynamic> toJson() {
    return {

      'employeeIds': employeeids,
    };
  }

}
