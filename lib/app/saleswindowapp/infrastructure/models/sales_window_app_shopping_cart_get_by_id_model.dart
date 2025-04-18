
class SalesWindowAppShoppingCartGetByIdModel {
  final String id;
  SalesWindowAppShoppingCartGetByIdModel({required this.id});
  factory SalesWindowAppShoppingCartGetByIdModel.fromJson(Map<String, dynamic> json) {
    return SalesWindowAppShoppingCartGetByIdModel(

      'Id': id,
    };
  }

}
