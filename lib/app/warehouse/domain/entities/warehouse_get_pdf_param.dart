
import 'get_warehouses_pdf_query_param.dart';
class WarehouseGetPdfParam {
  final GetWarehousesPdfQuery getWarehousesPdfQuery;
  WarehouseGetPdfParam({required this.getWarehousesPdfQuery});
 Map<String, dynamic> toJson() {
    return
          getWarehousesPdfQuery.toJson();
          }    
        }
          