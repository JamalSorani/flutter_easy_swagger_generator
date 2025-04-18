
import 'export_package_to_excel_query_param_param.dart';
class PackageExportToExcelParam {
  final ExportPackageToExcelQueryParam exportPackageToExcelQueryParam;
  PackageExportToExcelParam({required this.exportPackageToExcelQueryParam});
 Map<String, dynamic> toJson() {
    return
          exportPackageToExcelQueryParam.toJson();
          }    
        }
          