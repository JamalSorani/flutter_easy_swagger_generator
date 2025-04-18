
import 'get_sent_notifications_to_pdf_query_param_param.dart';
class NotificationGetSentsPdfParam {
  final GetSentNotificationsToPdfQueryParam getSentNotificationsToPdfQueryParam;
  NotificationGetSentsPdfParam({required this.getSentNotificationsToPdfQueryParam});
 Map<String, dynamic> toJson() {
    return
          getSentNotificationsToPdfQueryParam.toJson();
          }    
        }
          