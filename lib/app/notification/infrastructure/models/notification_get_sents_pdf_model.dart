
import 'get_sent_notifications_to_pdf_query_model_model.dart';
class NotificationGetSentsPdfModel {
  final GetSentNotificationsToPdfQueryModel getSentNotificationsToPdfQueryModel;
  NotificationGetSentsPdfModel({required this.getSentNotificationsToPdfQueryModel});
 factory NotificationGetSentsPdfModel.fromJson(Map<String, dynamic> json) {
    return NotificationGetSentsPdfModel(
   getSentNotificationsToPdfQueryModel:       getSentNotificationsToPdfQueryModel.fromJson(json),
          );
        }    
        }
          