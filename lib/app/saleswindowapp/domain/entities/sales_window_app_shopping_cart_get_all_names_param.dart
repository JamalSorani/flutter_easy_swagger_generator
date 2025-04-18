
import 'get_all_shopping_cart_names_query_param.dart';
class SalesWindowAppShoppingCartGetAllNamesParam {
  final GetAllShoppingCartNamesQuery request;
  SalesWindowAppShoppingCartGetAllNamesParam({required this.request});
  Map<String, dynamic> toJson() {
    return {

      'request': request,
    };
  }

}
