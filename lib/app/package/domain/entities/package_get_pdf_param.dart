
import 'get_packages_pdf_query.dart';
class PackageGetPdfParam {
  final GetPackagesPdfQuery getPackagesPdfQuery;
  PackageGetPdfParam({required this.getPackagesPdfQuery});
 Map<String, dynamic> toJson() {
    return
          getPackagesPdfQuery.toJson();
          }    
        }
          