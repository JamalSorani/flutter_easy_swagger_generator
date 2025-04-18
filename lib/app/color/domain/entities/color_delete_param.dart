
class ColorDeleteParam {
  final String id;
  final List<String> applicationjson;
  ColorDeleteParam({required this.id, required this.applicationjson});
  Map<String, dynamic> toJson() {
    return {

      'id': id,
      'application/json': applicationjson,
    };
  }

}
