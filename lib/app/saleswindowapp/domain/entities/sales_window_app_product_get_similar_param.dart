
class SalesWindowAppProductGetSimilarParam {
  final String productId;
  SalesWindowAppProductGetSimilarParam({required this.productId});
  Map<String, dynamic> toJson() {
    return {

      'ProductId': productId,
    };
  }

}
