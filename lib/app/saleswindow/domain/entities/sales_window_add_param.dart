
import 'add_sales_window_command_param.dart';
class SalesWindowAddParam {
  final AddSalesWindowCommand addSalesWindowCommand;
  SalesWindowAddParam({required this.addSalesWindowCommand});
 Map<String, dynamic> toJson() {
    return
          addSalesWindowCommand.toJson();
          }    
        }
          