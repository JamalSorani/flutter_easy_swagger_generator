
import 'get_all_shopping_cart_names_query_param_param.dart';
class SalesWindowAppShoppingCartGetAllNamesParam {
  final GetAllShoppingCartNamesQueryParam request;
  SalesWindowAppShoppingCartGetAllNamesParam({required this.request});
  Map<String, dynamic> toJson() {
    return {

      'request': request,
    };
  }

}
