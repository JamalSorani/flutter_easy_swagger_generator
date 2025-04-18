
import 'get_manufacturers_pdf_query_param_param.dart';
class ManufacturerGetPdfParam {
  final GetManufacturersPdfQueryParam getManufacturersPdfQueryParam;
  ManufacturerGetPdfParam({required this.getManufacturersPdfQueryParam});
 Map<String, dynamic> toJson() {
    return
          getManufacturersPdfQueryParam.toJson();
          }    
        }
          