
import 'export_inbound_or_outbound_processes_to_excel_query_model_model.dart';
class InventoryManagmentExportInboundOrOutboundProcessesToExcelModel {
  final ExportInboundOrOutboundProcessesToExcelQueryModel exportInboundOrOutboundProcessesToExcelQueryModel;
  InventoryManagmentExportInboundOrOutboundProcessesToExcelModel({required this.exportInboundOrOutboundProcessesToExcelQueryModel});
 factory InventoryManagmentExportInboundOrOutboundProcessesToExcelModel.fromJson(Map<String, dynamic> json) {
    return InventoryManagmentExportInboundOrOutboundProcessesToExcelModel(
   exportInboundOrOutboundProcessesToExcelQueryModel:       ExportInboundOrOutboundProcessesToExcelQueryModel.fromJson(json),
          );
        }    
        }
          