
class SalesWindowAppShoppingCartDeleteModel {
  final String id;
  final List<String> applicationjson;
  SalesWindowAppShoppingCartDeleteModel({required this.id, required this.applicationjson});
  factory SalesWindowAppShoppingCartDeleteModel.fromJson(Map<String, dynamic> json) {
    return SalesWindowAppShoppingCartDeleteModel(

      id: json["id"] ,
      applicationjson: json["application/json"],
    );
  }

}
