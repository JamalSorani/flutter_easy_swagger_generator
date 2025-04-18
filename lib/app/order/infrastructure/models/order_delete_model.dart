
class OrderDeleteModel {
  final String id;
  final List<String> applicationjson;
  OrderDeleteModel({required this.id, required this.applicationjson});
  factory OrderDeleteModel.fromJson(Map<String, dynamic> json) {
    return OrderDeleteModel(

      id: json["id"] ,
      applicationjson: json["application/json"],
    );
  }

}
