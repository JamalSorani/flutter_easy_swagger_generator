
import 'modify_sales_window_command_param_param.dart';
class SalesWindowModifyParam {
  final ModifySalesWindowCommandParam modifySalesWindowCommandParam;
  SalesWindowModifyParam({required this.modifySalesWindowCommandParam});
 Map<String, dynamic> toJson() {
    return
          modifySalesWindowCommandParam.toJson();
          }    
        }
          