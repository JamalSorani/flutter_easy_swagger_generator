
import 'get_packages_pdf_query_param_param.dart';
class PackageGetPdfParam {
  final GetPackagesPdfQueryParam getPackagesPdfQueryParam;
  PackageGetPdfParam({required this.getPackagesPdfQueryParam});
 Map<String, dynamic> toJson() {
    return
          getPackagesPdfQueryParam.toJson();
          }    
        }
          