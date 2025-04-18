
class QuantityStyleDeleteModel {
  final String id;
  final List<String> applicationjson;
  QuantityStyleDeleteModel({required this.id, required this.applicationjson});
  factory QuantityStyleDeleteModel.fromJson(Map<String, dynamic> json) {
    return QuantityStyleDeleteModel(

      id: json["id"] ,
      applicationjson: json["application/json"],
    );
  }

}
