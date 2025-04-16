
class WarehouseDeleteParam {
  final String id;
  WarehouseDeleteParam({required this.id});
  Map<String, dynamic> toJson() {
    return {

      'id': id,
    };
  }

}
