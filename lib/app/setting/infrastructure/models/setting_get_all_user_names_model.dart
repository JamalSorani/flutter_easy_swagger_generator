
import 'get_all_employee_names_query_model_model.dart';
class SettingGetAllUserNamesModel {
  final GetAllEmployeeNamesQueryModel request;
  SettingGetAllUserNamesModel({required this.request});
  factory SettingGetAllUserNamesModel.fromJson(Map<String, dynamic> json) {
    return SettingGetAllUserNamesModel(

      'request': request,
    };
  }

}
