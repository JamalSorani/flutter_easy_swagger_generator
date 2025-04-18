
class ColorDeleteModel {
  final String id;
  final List<String> applicationjson;
  ColorDeleteModel({required this.id, required this.applicationjson});
  factory ColorDeleteModel.fromJson(Map<String, dynamic> json) {
    return ColorDeleteModel(

      id: json["id"] ,
      applicationjson: json["application/json"],
    );
  }

}
