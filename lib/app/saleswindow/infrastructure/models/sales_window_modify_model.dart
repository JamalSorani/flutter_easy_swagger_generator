
import 'modify_sales_window_command_model_model.dart';
class SalesWindowModifyModel {
  final ModifySalesWindowCommandModel modifySalesWindowCommandModel;
  SalesWindowModifyModel({required this.modifySalesWindowCommandModel});
 factory SalesWindowModifyModel.fromJson(Map<String, dynamic> json) {
    return SalesWindowModifyModel(
   modifySalesWindowCommandModel:       ModifySalesWindowCommandModel.fromJson(json),
          );
        }    
        }
          