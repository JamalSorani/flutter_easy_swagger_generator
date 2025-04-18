class ExportEmployeesToExcelQueryParam {
  final List<String> employeeids;

  ExportEmployeesToExcelQueryParam({
    required this.employeeids,
  });
  Map<String, dynamic> toJson() {
    return {

      'employeeIds': employeeids,
    };
  }

}
