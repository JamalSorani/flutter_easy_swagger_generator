
import 'export_customers_to_excel_query_model_model.dart';
class CustomerExportToExcelModel {
  final ExportCustomersToExcelQueryModel exportCustomersToExcelQueryModel;
  CustomerExportToExcelModel({required this.exportCustomersToExcelQueryModel});
 factory CustomerExportToExcelModel.fromJson(Map<String, dynamic> json) {
    return CustomerExportToExcelModel(
   exportCustomersToExcelQueryModel:       ExportCustomersToExcelQueryModel.fromJson(json),
          );
        }    
        }
          