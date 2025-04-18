
class FillStyleDeleteModel {
  final String id;
  final List<String> applicationjson;
  FillStyleDeleteModel({required this.id, required this.applicationjson});
  factory FillStyleDeleteModel.fromJson(Map<String, dynamic> json) {
    return FillStyleDeleteModel(

      id: json["id"] ,
      applicationjson: json["application/json"],
    );
  }

}
