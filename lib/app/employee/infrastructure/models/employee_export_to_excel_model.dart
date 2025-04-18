
import 'export_employees_to_excel_query_model_model.dart';
class EmployeeExportToExcelModel {
  final ExportEmployeesToExcelQueryModel exportEmployeesToExcelQueryModel;
  EmployeeExportToExcelModel({required this.exportEmployeesToExcelQueryModel});
 factory EmployeeExportToExcelModel.fromJson(Map<String, dynamic> json) {
    return EmployeeExportToExcelModel(
   exportEmployeesToExcelQueryModel:       ExportEmployeesToExcelQueryModel.fromJson(json),
          );
        }    
        }
          