
import 'export_sales_windows_to_excel_query_model_model.dart';
class SalesWindowExportToExcelModel {
  final ExportSalesWindowsToExcelQueryModel exportSalesWindowsToExcelQueryModel;
  SalesWindowExportToExcelModel({required this.exportSalesWindowsToExcelQueryModel});
 factory SalesWindowExportToExcelModel.fromJson(Map<String, dynamic> json) {
    return SalesWindowExportToExcelModel(
   exportSalesWindowsToExcelQueryModel:       ExportSalesWindowsToExcelQueryModel.fromJson(json),
          );
        }    
        }
          