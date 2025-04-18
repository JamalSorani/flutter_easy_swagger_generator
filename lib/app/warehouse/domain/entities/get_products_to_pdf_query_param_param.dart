class GetProductsToPdfQueryParam {
  final String warehouseid;
  final List<String> productids;

  GetProductsToPdfQueryParam({
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
