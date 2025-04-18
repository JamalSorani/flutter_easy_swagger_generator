class GetProductsToPdfQueryModel {
  final String saleswindowId;
  final List<String> productids;

  GetProductsToPdfQueryModel({
    required this.saleswindowId,
    required this.productids,
  });
  Map<String, dynamic> toJson() {
    return {

      'salesWindowId': saleswindowId,
      'productIds': productids,
    };
  }

}
