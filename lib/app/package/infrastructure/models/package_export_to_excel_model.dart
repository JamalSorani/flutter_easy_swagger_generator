
import 'export_package_to_excel_query_model_model.dart';
class PackageExportToExcelModel {
  final ExportPackageToExcelQueryModel exportPackageToExcelQueryModel;
  PackageExportToExcelModel({required this.exportPackageToExcelQueryModel});
 factory PackageExportToExcelModel.fromJson(Map<String, dynamic> json) {
    return PackageExportToExcelModel(
   exportPackageToExcelQueryModel:       ExportPackageToExcelQueryModel.fromJson(json),
          );
        }    
        }
          