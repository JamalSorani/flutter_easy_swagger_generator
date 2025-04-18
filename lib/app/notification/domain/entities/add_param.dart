
import 'add_notification_command_param.dart';
class NotificationAddParam {
  final AddNotificationCommand addNotificationCommand;
  NotificationAddParam({required this.addNotificationCommand});
 Map<String, dynamic> toJson() {
    return
          addNotificationCommand.toJson();
          }    
        }
          