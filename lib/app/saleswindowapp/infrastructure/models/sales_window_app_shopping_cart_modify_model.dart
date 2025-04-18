
import 'modify_shopping_cart_command_model_model.dart';
class SalesWindowAppShoppingCartModifyModel {
  final ModifyShoppingCartCommandModel modifyShoppingCartCommandModel;
  SalesWindowAppShoppingCartModifyModel({required this.modifyShoppingCartCommandModel});
 factory SalesWindowAppShoppingCartModifyModel.fromJson(Map<String, dynamic> json) {
    return SalesWindowAppShoppingCartModifyModel(
   modifyShoppingCartCommandModel:       ModifyShoppingCartCommandModel.fromJson(json),
          );
        }    
        }
          