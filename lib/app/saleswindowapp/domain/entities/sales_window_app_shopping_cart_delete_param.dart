
class SalesWindowAppShoppingCartDeleteParam {
  final String id;
  final List<String> applicationjson;
  SalesWindowAppShoppingCartDeleteParam({required this.id, required this.applicationjson});
  Map<String, dynamic> toJson() {
    return {

      'id': id,
      'application/json': applicationjson,
    };
  }

}
