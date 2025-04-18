
class ProductGetAllNamesModel {
  final String search;
  final String warehouseOrSalesWindowId;
  final String storageLocation;
  final double quantity;
  ProductGetAllNamesModel({required this.search, required this.warehouseOrSalesWindowId, required this.storageLocation, required this.quantity});
  factory ProductGetAllNamesModel.fromJson(Map<String, dynamic> json) {
    return ProductGetAllNamesModel(

      search: json["Search"] ,
      warehouseOrSalesWindowId: json["WarehouseOrSalesWindowId"] ,
      storageLocation: json["StorageLocation"] ,
      quantity: json["Quantity"] ,
    );
  }

}
