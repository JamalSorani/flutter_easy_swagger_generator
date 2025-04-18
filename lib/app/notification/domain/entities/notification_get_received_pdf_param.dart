
import 'get_received_notifications_to_pdf_query_param_param.dart';
class NotificationGetReceivedPdfParam {
  final GetReceivedNotificationsToPdfQueryParam getReceivedNotificationsToPdfQueryParam;
  NotificationGetReceivedPdfParam({required this.getReceivedNotificationsToPdfQueryParam});
 Map<String, dynamic> toJson() {
    return
          getReceivedNotificationsToPdfQueryParam.toJson();
          }    
        }
          