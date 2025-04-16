
import 'get_warehouses_pdf_query.dart';
class WarehouseGetPdfParam {
  final GetWarehousesPdfQuery getWarehousesPdfQuery;
  WarehouseGetPdfParam({required this.getWarehousesPdfQuery});
 Map<String, dynamic> toJson() {
    return
          getWarehousesPdfQuery.toJson();
          }    
        }
          