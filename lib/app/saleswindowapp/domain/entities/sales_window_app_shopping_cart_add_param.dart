
import 'add_shopping_cart_command_param_param.dart';
class SalesWindowAppShoppingCartAddParam {
  final AddShoppingCartCommandParam addShoppingCartCommandParam;
  SalesWindowAppShoppingCartAddParam({required this.addShoppingCartCommandParam});
 Map<String, dynamic> toJson() {
    return
          addShoppingCartCommandParam.toJson();
          }    
        }
          