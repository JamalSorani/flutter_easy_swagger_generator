
import 'add_notification_command.dart';
class NotificationAddParam {
  final AddNotificationCommand addNotificationCommand;
  NotificationAddParam({required this.addNotificationCommand});
 Map<String, dynamic> toJson() {
    return
          addNotificationCommand.toJson();
          }    
        }
          