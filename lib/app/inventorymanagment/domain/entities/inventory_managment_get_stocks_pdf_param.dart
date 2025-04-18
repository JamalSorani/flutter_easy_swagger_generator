
import 'get_stocks_pdf_query_param_param.dart';
class InventoryManagmentGetStocksPdfParam {
  final GetStocksPdfQueryParam getStocksPdfQueryParam;
  InventoryManagmentGetStocksPdfParam({required this.getStocksPdfQueryParam});
 Map<String, dynamic> toJson() {
    return
          getStocksPdfQueryParam.toJson();
          }    
        }
          