
import 'export_roles_to_excel_query_param_param.dart';
class RoleExportRolesToExcelParam {
  final ExportRolesToExcelQueryParam exportRolesToExcelQueryParam;
  RoleExportRolesToExcelParam({required this.exportRolesToExcelQueryParam});
 Map<String, dynamic> toJson() {
    return
          exportRolesToExcelQueryParam.toJson();
          }    
        }
          