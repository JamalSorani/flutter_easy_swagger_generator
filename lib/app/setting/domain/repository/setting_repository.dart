import 'package:either_dart/either.dart';
import '../../infrastructure/models/setting_get_all_setting_names_model.dart';
import '../../infrastructure/models/setting_get_all_user_names_model.dart';
import '../entities/setting_get_all_setting_names_param.dart';
import '../entities/setting_get_all_user_names_param.dart';

abstract class SettingRepository {
  Future<Either<String, SettingGetAllSettingNamesModel>> settingGetAllSettingNames({required SettingGetAllSettingNamesParam settingGetAllSettingNamesParam});

  Future<Either<String, SettingGetAllUserNamesModel>> settingGetAllUserNames({required SettingGetAllUserNamesParam settingGetAllUserNamesParam});

}
