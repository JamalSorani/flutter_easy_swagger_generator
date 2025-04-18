
class CustomerDeleteParam {
  final String id;
  final List<String> applicationjson;
  CustomerDeleteParam({required this.id, required this.applicationjson});
  Map<String, dynamic> toJson() {
    return {

      'id': id,
    };
  }

}
