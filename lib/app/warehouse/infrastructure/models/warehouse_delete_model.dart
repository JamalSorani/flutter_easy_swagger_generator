
class WarehouseDeleteModel {
  final String id;
  final List<String> applicationjson;
  WarehouseDeleteModel({required this.id, required this.applicationjson});
  factory WarehouseDeleteModel.fromJson(Map<String, dynamic> json) {
    return WarehouseDeleteModel(

      'id': id,
      'application/json': applicationjson,
    };
  }

}
