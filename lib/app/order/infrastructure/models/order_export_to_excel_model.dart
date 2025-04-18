
import 'export_orders_to_excel_query_model_model.dart';
class OrderExportToExcelModel {
  final ExportOrdersToExcelQueryModel exportOrdersToExcelQueryModel;
  OrderExportToExcelModel({required this.exportOrdersToExcelQueryModel});
 factory OrderExportToExcelModel.fromJson(Map<String, dynamic> json) {
    return OrderExportToExcelModel(
   exportOrdersToExcelQueryModel:       exportOrdersToExcelQueryModel.fromJson(json),
          );
        }    
        }
          