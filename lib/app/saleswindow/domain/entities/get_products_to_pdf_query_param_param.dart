class GetProductsToPdfQueryParam {
  final String saleswindowId;
  final List<String> productids;

  GetProductsToPdfQueryParam({
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
