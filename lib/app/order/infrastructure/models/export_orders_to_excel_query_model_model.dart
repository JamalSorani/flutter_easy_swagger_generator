class ExportOrdersToExcelQueryModel {
  final List<String> orderids;

  ExportOrdersToExcelQueryModel({
    required this.orderids,
  });
  factory ExportOrdersToExcelQueryModel.fromJson(Map<String,dynamic>json){
  return ExportOrdersToExcelQueryModel(

      orderids : json["orderIds"],
    );
  }

}
