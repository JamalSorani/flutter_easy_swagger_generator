
import 'modify_shopping_cart_command_param.dart';
class SalesWindowAppShoppingCartModifyParam {
  final ModifyShoppingCartCommand modifyShoppingCartCommand;
  SalesWindowAppShoppingCartModifyParam({required this.modifyShoppingCartCommand});
 Map<String, dynamic> toJson() {
    return
          modifyShoppingCartCommand.toJson();
          }    
        }
          