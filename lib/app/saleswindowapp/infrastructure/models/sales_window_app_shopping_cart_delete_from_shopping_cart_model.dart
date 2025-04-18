
class SalesWindowAppShoppingCartDeleteFromShoppingCartModel {
  final String id;
  final List<String> applicationjson;
  SalesWindowAppShoppingCartDeleteFromShoppingCartModel({required this.id, required this.applicationjson});
  factory SalesWindowAppShoppingCartDeleteFromShoppingCartModel.fromJson(Map<String, dynamic> json) {
    return SalesWindowAppShoppingCartDeleteFromShoppingCartModel(

      id: json["id"] ,
      applicationjson: json["application/json"],
    );
  }

}
