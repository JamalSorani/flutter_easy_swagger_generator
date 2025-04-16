
import 'export_roles_to_excel_query.dart';
class RoleExportRolesToExcelParam {
  final ExportRolesToExcelQuery exportRolesToExcelQuery;
  RoleExportRolesToExcelParam({required this.exportRolesToExcelQuery});
 Map<String, dynamic> toJson() {
    return
          exportRolesToExcelQuery.toJson();
          }    
        }
          