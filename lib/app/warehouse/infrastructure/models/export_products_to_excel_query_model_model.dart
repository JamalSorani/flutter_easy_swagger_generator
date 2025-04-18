class ExportProductsToExcelQueryModel {
  final String warehouseid;
  final List<String> productids;

  ExportProductsToExcelQueryModel({
    required this.warehouseid,
    required this.productids,
  });
  factory ExportProductsToExcelQueryModel.fromJson(Map<String,dynamic>json){
  return ExportProductsToExcelQueryModel(

      warehouseid : json["warehouseId"],
      productids : json["productIds"],
    );
  }

}
