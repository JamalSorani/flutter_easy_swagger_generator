
class StoreDeleteParam {
  final String id;
  StoreDeleteParam({required this.id});
  Map<String, dynamic> toJson() {
    return {

      'id': id,
    };
  }

}
