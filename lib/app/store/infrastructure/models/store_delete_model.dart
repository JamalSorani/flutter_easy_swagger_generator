
class StoreDeleteModel {
  final String id;
  final List<String> applicationjson;
  StoreDeleteModel({required this.id, required this.applicationjson});
  factory StoreDeleteModel.fromJson(Map<String, dynamic> json) {
    return StoreDeleteModel(

      id: json["id"] ,
      applicationjson: json["application/json"],
    );
  }

}
