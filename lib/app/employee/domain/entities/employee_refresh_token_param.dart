
import 'refresh_token_command_param_param.dart';
class EmployeeRefreshTokenParam {
  final RefreshTokenCommandParam refreshTokenCommandParam;
  EmployeeRefreshTokenParam({required this.refreshTokenCommandParam});
 Map<String, dynamic> toJson() {
    return
          refreshTokenCommandParam.toJson();
          }    
        }
          