class ExportStocksToExcelQueryModel {
  final List<String> ids;

  ExportStocksToExcelQueryModel({
    required this.ids,
  });
  factory ExportStocksToExcelQueryModel.fromJson(Map<String,dynamic>json){
  return ExportStocksToExcelQueryModel(

      ids : json["ids"],
    );
  }

}
