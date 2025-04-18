class GetProductsToPdfQueryModel {
  final String warehouseid;
  final List<String> productids;

  GetProductsToPdfQueryModel({
    required this.warehouseid,
    required this.productids,
  });
  Map<String, dynamic> toJson() {
    return {

      'warehouseId': warehouseid,
      'productIds': productids,
    };
  }

}
