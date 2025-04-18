
import 'add_notification_command_param_param.dart';
class NotificationAddParam {
  final AddNotificationCommandParam addNotificationCommandParam;
  NotificationAddParam({required this.addNotificationCommandParam});
 Map<String, dynamic> toJson() {
    return
          addNotificationCommandParam.toJson();
          }    
        }
          