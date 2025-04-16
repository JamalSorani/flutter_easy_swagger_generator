
class ProductDeleteParam {
  final String id;
  ProductDeleteParam({required this.id});
  Map<String, dynamic> toJson() {
    return {

      'id': id,
    };
  }

}
