
class SourceDeleteParam {
  final String id;
  final List<String> applicationjson;
  SourceDeleteParam({required this.id, required this.applicationjson});
  Map<String, dynamic> toJson() {
    return {

      'id': id,
    };
  }

}
