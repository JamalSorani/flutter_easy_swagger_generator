
class StoreDeleteModel {
  final String id;
  final List<String> applicationjson;
  StoreDeleteModel({required this.id, required this.applicationjson});
  factory StoreDeleteModel.fromJson(Map<String, dynamic> json) {
    return StoreDeleteModel(

      'id': id,
      'application/json': applicationjson,
    };
  }

}
