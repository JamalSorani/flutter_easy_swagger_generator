
import 'add_shopping_cart_command_model_model.dart';
class SalesWindowAppShoppingCartAddModel {
  final AddShoppingCartCommandModel addShoppingCartCommandModel;
  SalesWindowAppShoppingCartAddModel({required this.addShoppingCartCommandModel});
 factory SalesWindowAppShoppingCartAddModel.fromJson(Map<String, dynamic> json) {
    return SalesWindowAppShoppingCartAddModel(
   addShoppingCartCommandModel:       AddShoppingCartCommandModel.fromJson(json),
          );
        }    
        }
          