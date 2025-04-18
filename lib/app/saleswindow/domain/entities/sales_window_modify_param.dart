
import 'modify_sales_window_command_param.dart';
class SalesWindowModifyParam {
  final ModifySalesWindowCommand modifySalesWindowCommand;
  SalesWindowModifyParam({required this.modifySalesWindowCommand});
 Map<String, dynamic> toJson() {
    return
          modifySalesWindowCommand.toJson();
          }    
        }
          