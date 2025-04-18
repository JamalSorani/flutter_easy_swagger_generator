
import 'export_package_to_excel_query_param.dart';
class PackageExportToExcelParam {
  final ExportPackageToExcelQuery exportPackageToExcelQuery;
  PackageExportToExcelParam({required this.exportPackageToExcelQuery});
 Map<String, dynamic> toJson() {
    return
          exportPackageToExcelQuery.toJson();
          }    
        }
          