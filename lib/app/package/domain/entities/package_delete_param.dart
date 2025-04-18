
class PackageDeleteParam {
  final String id;
  final List<String> applicationjson;
  PackageDeleteParam({required this.id, required this.applicationjson});
  Map<String, dynamic> toJson() {
    return {

      'id': id,
    };
  }

}
