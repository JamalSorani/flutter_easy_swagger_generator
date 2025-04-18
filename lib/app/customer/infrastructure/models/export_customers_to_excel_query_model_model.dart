class ExportCustomersToExcelQueryModel {
  final List<String> customerids;

  ExportCustomersToExcelQueryModel({
    required this.customerids,
  });
  factory ExportCustomersToExcelQueryModel.fromJson(Map<String,dynamic>json){
  return ExportCustomersToExcelQueryModel(

      customerids : json["customerIds"],
    );
  }

}
