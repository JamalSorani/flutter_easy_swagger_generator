
import 'get_sent_notifications_to_pdf_query.dart';
class NotificationGetSentsPdfParam {
  final GetSentNotificationsToPdfQuery getSentNotificationsToPdfQuery;
  NotificationGetSentsPdfParam({required this.getSentNotificationsToPdfQuery});
 Map<String, dynamic> toJson() {
    return
          getSentNotificationsToPdfQuery.toJson();
          }    
        }
          