
class PackageDeleteParam {
  final String id;
  PackageDeleteParam({required this.id});
  Map<String, dynamic> toJson() {
    return {

      'id': id,
    };
  }

}
