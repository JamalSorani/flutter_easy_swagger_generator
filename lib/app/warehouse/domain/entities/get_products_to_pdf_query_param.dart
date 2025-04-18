class GetProductsToPdfQuery {
  final String warehouseid;
  final List<String> productids;

  GetProductsToPdfQuery({
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
