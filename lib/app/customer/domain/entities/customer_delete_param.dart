
class CustomerDeleteParam {
  final String id;
  CustomerDeleteParam({required this.id});
  Map<String, dynamic> toJson() {
    return {

      'id': id,
    };
  }

}
