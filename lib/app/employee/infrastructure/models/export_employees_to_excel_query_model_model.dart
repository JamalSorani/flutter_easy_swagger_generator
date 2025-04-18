class ExportEmployeesToExcelQueryModel {
  final List<String> employeeids;

  ExportEmployeesToExcelQueryModel({
    required this.employeeids,
  });
  factory ExportEmployeesToExcelQueryModel.fromJson(Map<String,dynamic>json){
  return ExportEmployeesToExcelQueryModel(

      employeeids : json["employeeIds"],
    );
  }

}
