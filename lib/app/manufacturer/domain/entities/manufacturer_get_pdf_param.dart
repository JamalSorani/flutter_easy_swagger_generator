
import 'get_manufacturers_pdf_query_param.dart';
class ManufacturerGetPdfParam {
  final GetManufacturersPdfQuery getManufacturersPdfQuery;
  ManufacturerGetPdfParam({required this.getManufacturersPdfQuery});
 Map<String, dynamic> toJson() {
    return
          getManufacturersPdfQuery.toJson();
          }    
        }
          