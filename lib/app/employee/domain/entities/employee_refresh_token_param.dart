
import 'refresh_token_command_param.dart';
class EmployeeRefreshTokenParam {
  final RefreshTokenCommand refreshTokenCommand;
  EmployeeRefreshTokenParam({required this.refreshTokenCommand});
 Map<String, dynamic> toJson() {
    return
          refreshTokenCommand.toJson();
          }    
        }
          