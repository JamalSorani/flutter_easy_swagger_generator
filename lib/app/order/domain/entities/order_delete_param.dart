
class OrderDeleteParam {
  final String id;
  OrderDeleteParam({required this.id});
  Map<String, dynamic> toJson() {
    return {

      'id': id,
    };
  }

}
