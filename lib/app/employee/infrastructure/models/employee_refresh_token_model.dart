
import 'refresh_token_command_model_model.dart';
class EmployeeRefreshTokenModel {
  final RefreshTokenCommandModel refreshTokenCommandModel;
  EmployeeRefreshTokenModel({required this.refreshTokenCommandModel});
 factory EmployeeRefreshTokenModel.fromJson(Map<String, dynamic> json) {
    return EmployeeRefreshTokenModel(
   refreshTokenCommandModel:       RefreshTokenCommandModel.fromJson(json),
          );
        }    
        }
          