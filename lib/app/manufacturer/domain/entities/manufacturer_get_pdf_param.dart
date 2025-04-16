
import 'get_manufacturers_pdf_query.dart';
class ManufacturerGetPdfParam {
  final GetManufacturersPdfQuery getManufacturersPdfQuery;
  ManufacturerGetPdfParam({required this.getManufacturersPdfQuery});
 Map<String, dynamic> toJson() {
    return
          getManufacturersPdfQuery.toJson();
          }    
        }
          