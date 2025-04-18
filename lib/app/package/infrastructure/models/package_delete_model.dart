
class PackageDeleteModel {
  final String id;
  final List<String> applicationjson;
  PackageDeleteModel({required this.id, required this.applicationjson});
  factory PackageDeleteModel.fromJson(Map<String, dynamic> json) {
    return PackageDeleteModel(

      id: json["id"] ,
      applicationjson: json["application/json"],
    );
  }

}
