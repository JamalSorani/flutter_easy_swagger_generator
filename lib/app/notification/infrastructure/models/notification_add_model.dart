
import 'add_notification_command_model_model.dart';
class NotificationAddModel {
  final AddNotificationCommandModel addNotificationCommandModel;
  NotificationAddModel({required this.addNotificationCommandModel});
 factory NotificationAddModel.fromJson(Map<String, dynamic> json) {
    return NotificationAddModel(
   addNotificationCommandModel:       AddNotificationCommandModel.fromJson(json),
          );
        }    
        }
          