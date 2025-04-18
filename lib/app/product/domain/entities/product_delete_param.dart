
class ProductDeleteParam {
  final String id;
  final List<String> applicationjson;
  ProductDeleteParam({required this.id, required this.applicationjson});
  Map<String, dynamic> toJson() {
    return {

      'id': id,
      'application/json': applicationjson,
    };
  }

}
