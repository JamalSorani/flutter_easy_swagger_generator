
import 'export_employees_to_excel_query_param_param.dart';
class EmployeeExportToExcelParam {
  final ExportEmployeesToExcelQueryParam exportEmployeesToExcelQueryParam;
  EmployeeExportToExcelParam({required this.exportEmployeesToExcelQueryParam});
 Map<String, dynamic> toJson() {
    return
          exportEmployeesToExcelQueryParam.toJson();
          }    
        }
          