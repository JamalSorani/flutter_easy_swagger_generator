
import 'get_received_notifications_to_pdf_query_model_model.dart';
class NotificationGetReceivedPdfModel {
  final GetReceivedNotificationsToPdfQueryModel getReceivedNotificationsToPdfQueryModel;
  NotificationGetReceivedPdfModel({required this.getReceivedNotificationsToPdfQueryModel});
 factory NotificationGetReceivedPdfModel.fromJson(Map<String, dynamic> json) {
    return NotificationGetReceivedPdfModel(
   getReceivedNotificationsToPdfQueryModel:       GetReceivedNotificationsToPdfQueryModel.fromJson(json),
          );
        }    
        }
          