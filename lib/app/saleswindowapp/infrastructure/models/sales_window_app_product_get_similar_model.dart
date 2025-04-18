
class SalesWindowAppProductGetSimilarModel {
  final String productId;
  SalesWindowAppProductGetSimilarModel({required this.productId});
  factory SalesWindowAppProductGetSimilarModel.fromJson(Map<String, dynamic> json) {
    return SalesWindowAppProductGetSimilarModel(

      'ProductId': productId,
    };
  }

}
