
import 'export_employees_to_excel_query_param.dart';
class EmployeeExportToExcelParam {
  final ExportEmployeesToExcelQuery exportEmployeesToExcelQuery;
  EmployeeExportToExcelParam({required this.exportEmployeesToExcelQuery});
 Map<String, dynamic> toJson() {
    return
          exportEmployeesToExcelQuery.toJson();
          }    
        }
          