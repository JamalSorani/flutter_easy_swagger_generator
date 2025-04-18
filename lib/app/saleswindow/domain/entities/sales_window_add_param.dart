
import 'add_sales_window_command_param_param.dart';
class SalesWindowAddParam {
  final AddSalesWindowCommandParam addSalesWindowCommandParam;
  SalesWindowAddParam({required this.addSalesWindowCommandParam});
 Map<String, dynamic> toJson() {
    return
          addSalesWindowCommandParam.toJson();
          }    
        }
          