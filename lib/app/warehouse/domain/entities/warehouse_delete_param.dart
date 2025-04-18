
class WarehouseDeleteParam {
  final String id;
  final List<String> applicationjson;
  WarehouseDeleteParam({required this.id, required this.applicationjson});
  Map<String, dynamic> toJson() {
    return {

      'id': id,
    };
  }

}
