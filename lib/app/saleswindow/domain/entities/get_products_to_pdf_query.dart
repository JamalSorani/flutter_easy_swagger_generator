class GetProductsToPdfQuery {
  final String saleswindowId;
  final dynamic productids;

  GetProductsToPdfQuery({
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
