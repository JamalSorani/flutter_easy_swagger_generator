
import 'export_received_notification_to_excel_query.dart';
class NotificationExportReceivedNotificationsToExcelParam {
  final ExportReceivedNotificationToExcelQuery exportReceivedNotificationToExcelQuery;
  NotificationExportReceivedNotificationsToExcelParam({required this.exportReceivedNotificationToExcelQuery});
 Map<String, dynamic> toJson() {
    return
          exportReceivedNotificationToExcelQuery.toJson();
          }    
        }
          