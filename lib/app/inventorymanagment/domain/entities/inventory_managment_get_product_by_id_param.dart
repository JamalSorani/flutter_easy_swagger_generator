
class InventoryManagmentGetProductByIdParam {
  final String productId;
  InventoryManagmentGetProductByIdParam({required this.productId});
  Map<String, dynamic> toJson() {
    return {

      'ProductId': productId,
    };
  }

}
