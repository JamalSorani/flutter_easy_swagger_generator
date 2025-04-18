
class CustomerDeleteModel {
  final String id;
  final List<String> applicationjson;
  CustomerDeleteModel({required this.id, required this.applicationjson});
  factory CustomerDeleteModel.fromJson(Map<String, dynamic> json) {
    return CustomerDeleteModel(

      id: json["id"] ,
      applicationjson: json["application/json"],
    );
  }

}
