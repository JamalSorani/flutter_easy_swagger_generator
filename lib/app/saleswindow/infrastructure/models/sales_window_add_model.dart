
import 'add_sales_window_command_model_model.dart';
class SalesWindowAddModel {
  final AddSalesWindowCommandModel addSalesWindowCommandModel;
  SalesWindowAddModel({required this.addSalesWindowCommandModel});
 factory SalesWindowAddModel.fromJson(Map<String, dynamic> json) {
    return SalesWindowAddModel(
   addSalesWindowCommandModel:       AddSalesWindowCommandModel.fromJson(json),
          );
        }    
        }
          