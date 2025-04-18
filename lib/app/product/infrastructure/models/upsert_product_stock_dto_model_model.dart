class UpsertProductStockDtoModel {
  final double weight;
  final double size;
  final int quantity;
  final String quantitystyleId;
  final String fillstyleAndQuantity;
  final String warehouseidOrSaleswindowId;
  final String storagelocation;

  UpsertProductStockDtoModel({
    required this.weight,
    required this.size,
    required this.quantity,
    required this.quantitystyleId,
    required this.fillstyleAndQuantity,
    required this.warehouseidOrSaleswindowId,
    required this.storagelocation,
  });
  Map<String, dynamic> toJson() {
    return {

      'weight': weight,
      'size': size,
      'quantity': quantity,
      'quantityStyleId': quantitystyleId,
      'fillStyleAndQuantity': fillstyleAndQuantity,
      'warehouseIdOrSaleswindowId': warehouseidOrSaleswindowId,
      'storageLocation': storagelocation,
    };
  }

}
