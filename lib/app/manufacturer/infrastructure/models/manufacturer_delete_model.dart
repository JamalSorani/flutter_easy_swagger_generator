
class ManufacturerDeleteModel {
  final String id;
  final List<String> applicationjson;
  ManufacturerDeleteModel({required this.id, required this.applicationjson});
  factory ManufacturerDeleteModel.fromJson(Map<String, dynamic> json) {
    return ManufacturerDeleteModel(

      id: json["id"] ,
      applicationjson: json["application/json"],
    );
  }

}
