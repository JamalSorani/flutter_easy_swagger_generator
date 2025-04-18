
import 'export_roles_to_excel_query_model_model.dart';
class RoleExportRolesToExcelModel {
  final ExportRolesToExcelQueryModel exportRolesToExcelQueryModel;
  RoleExportRolesToExcelModel({required this.exportRolesToExcelQueryModel});
 factory RoleExportRolesToExcelModel.fromJson(Map<String, dynamic> json) {
    return RoleExportRolesToExcelModel(
   exportRolesToExcelQueryModel:       ExportRolesToExcelQueryModel.fromJson(json),
          );
        }    
        }
          