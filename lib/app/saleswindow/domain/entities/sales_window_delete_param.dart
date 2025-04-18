
class SalesWindowDeleteParam {
  final String id;
  final List<String> applicationjson;
  SalesWindowDeleteParam({required this.id, required this.applicationjson});
  Map<String, dynamic> toJson() {
    return {

      'id': id,
    };
  }

}
