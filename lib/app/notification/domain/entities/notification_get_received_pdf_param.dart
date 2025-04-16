
import 'get_received_notifications_to_pdf_query.dart';
class NotificationGetReceivedPdfParam {
  final GetReceivedNotificationsToPdfQuery getReceivedNotificationsToPdfQuery;
  NotificationGetReceivedPdfParam({required this.getReceivedNotificationsToPdfQuery});
 Map<String, dynamic> toJson() {
    return
          getReceivedNotificationsToPdfQuery.toJson();
          }    
        }
          