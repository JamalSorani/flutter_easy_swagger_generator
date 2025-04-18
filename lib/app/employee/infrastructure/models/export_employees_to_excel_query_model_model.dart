class ExportEmployeesToExcelQueryModel {
  final List<String> employeeids;

  ExportEmployeesToExcelQueryModel({
    required this.employeeids,
  });
  Map<String, dynamic> toJson() {
    return {

      'employeeIds': employeeids,
    };
  }

}
