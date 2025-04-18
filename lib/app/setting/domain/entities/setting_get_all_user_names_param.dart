
import 'get_all_employee_names_query_param_param.dart';
class SettingGetAllUserNamesParam {
  final GetAllEmployeeNamesQueryParam request;
  SettingGetAllUserNamesParam({required this.request});
  Map<String, dynamic> toJson() {
    return {

      'request': request,
    };
  }

}
