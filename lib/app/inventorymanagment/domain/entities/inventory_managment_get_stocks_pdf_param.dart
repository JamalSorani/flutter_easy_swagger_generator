
import 'get_stocks_pdf_query.dart';
class InventoryManagmentGetStocksPdfParam {
  final GetStocksPdfQuery getStocksPdfQuery;
  InventoryManagmentGetStocksPdfParam({required this.getStocksPdfQuery});
 Map<String, dynamic> toJson() {
    return
          getStocksPdfQuery.toJson();
          }    
        }
          