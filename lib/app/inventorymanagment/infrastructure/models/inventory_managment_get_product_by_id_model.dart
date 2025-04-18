
class InventoryManagmentGetProductByIdModel {
  final String productId;
  InventoryManagmentGetProductByIdModel({required this.productId});
  factory InventoryManagmentGetProductByIdModel.fromJson(Map<String, dynamic> json) {
    return InventoryManagmentGetProductByIdModel(

      'ProductId': productId,
    };
  }

}
