
import 'export_employees_to_excel_query.dart';
class EmployeeExportToExcelParam {
  final ExportEmployeesToExcelQuery exportEmployeesToExcelQuery;
  EmployeeExportToExcelParam({required this.exportEmployeesToExcelQuery});
 Map<String, dynamic> toJson() {
    return
          exportEmployeesToExcelQuery.toJson();
          }    
        }
          