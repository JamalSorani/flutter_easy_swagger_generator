
import 'get_all_shopping_cart_names_query_model_model.dart';
class SalesWindowAppShoppingCartGetAllNamesModel {
  final GetAllShoppingCartNamesQueryModel request;
  SalesWindowAppShoppingCartGetAllNamesModel({required this.request});
  factory SalesWindowAppShoppingCartGetAllNamesModel.fromJson(Map<String, dynamic> json) {
    return SalesWindowAppShoppingCartGetAllNamesModel(

      'request': request,
    };
  }

}
