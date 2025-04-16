
class ManufacturerDeleteParam {
  final String id;
  ManufacturerDeleteParam({required this.id});
  Map<String, dynamic> toJson() {
    return {

      'id': id,
    };
  }

}
