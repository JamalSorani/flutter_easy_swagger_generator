
class StoreDeleteParam {
  final String id;
  final List<String> applicationjson;
  StoreDeleteParam({required this.id, required this.applicationjson});
  Map<String, dynamic> toJson() {
    return {

      'id': id,
    };
  }

}
