
import 'modify_sales_window_command.dart';
class SalesWindowModifyParam {
  final ModifySalesWindowCommand modifySalesWindowCommand;
  SalesWindowModifyParam({required this.modifySalesWindowCommand});
 Map<String, dynamic> toJson() {
    return
          modifySalesWindowCommand.toJson();
          }    
        }
          