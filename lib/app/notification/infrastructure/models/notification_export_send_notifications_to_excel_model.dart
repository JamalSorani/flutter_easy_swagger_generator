
import 'export_send_notifications_to_excel_query_model_model.dart';
class NotificationExportSendNotificationsToExcelModel {
  final ExportSendNotificationsToExcelQueryModel exportSendNotificationsToExcelQueryModel;
  NotificationExportSendNotificationsToExcelModel({required this.exportSendNotificationsToExcelQueryModel});
 factory NotificationExportSendNotificationsToExcelModel.fromJson(Map<String, dynamic> json) {
    return NotificationExportSendNotificationsToExcelModel(
   exportSendNotificationsToExcelQueryModel:       exportSendNotificationsToExcelQueryModel.fromJson(json),
          );
        }    
        }
          