
import 'add_shopping_cart_command_param.dart';
class SalesWindowAppShoppingCartAddParam {
  final AddShoppingCartCommand addShoppingCartCommand;
  SalesWindowAppShoppingCartAddParam({required this.addShoppingCartCommand});
 Map<String, dynamic> toJson() {
    return
          addShoppingCartCommand.toJson();
          }    
        }
          