
import 'get_warehouses_pdf_query_param_param.dart';
class WarehouseGetPdfParam {
  final GetWarehousesPdfQueryParam getWarehousesPdfQueryParam;
  WarehouseGetPdfParam({required this.getWarehousesPdfQueryParam});
 Map<String, dynamic> toJson() {
    return
          getWarehousesPdfQueryParam.toJson();
          }    
        }
          