
import 'export_received_notification_to_excel_query_model_model.dart';
class NotificationExportReceivedNotificationsToExcelModel {
  final ExportReceivedNotificationToExcelQueryModel exportReceivedNotificationToExcelQueryModel;
  NotificationExportReceivedNotificationsToExcelModel({required this.exportReceivedNotificationToExcelQueryModel});
 factory NotificationExportReceivedNotificationsToExcelModel.fromJson(Map<String, dynamic> json) {
    return NotificationExportReceivedNotificationsToExcelModel(
   exportReceivedNotificationToExcelQueryModel:       ExportReceivedNotificationToExcelQueryModel.fromJson(json),
          );
        }    
        }
          