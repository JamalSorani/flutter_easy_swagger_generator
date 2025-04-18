
class ManufacturerDeleteParam {
  final String id;
  final List<String> applicationjson;
  ManufacturerDeleteParam({required this.id, required this.applicationjson});
  Map<String, dynamic> toJson() {
    return {

      'id': id,
      'application/json': applicationjson,
    };
  }

}
