
import 'modify_shopping_cart_command_param_param.dart';
class SalesWindowAppShoppingCartModifyParam {
  final ModifyShoppingCartCommandParam modifyShoppingCartCommandParam;
  SalesWindowAppShoppingCartModifyParam({required this.modifyShoppingCartCommandParam});
 Map<String, dynamic> toJson() {
    return
          modifyShoppingCartCommandParam.toJson();
          }    
        }
          