
class OrderDeleteParam {
  final String id;
  final List<String> applicationjson;
  OrderDeleteParam({required this.id, required this.applicationjson});
  Map<String, dynamic> toJson() {
    return {

      'id': id,
      'application/json': applicationjson,
    };
  }

}
