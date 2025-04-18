
import 'get_all_employee_names_query_param.dart';
class SettingGetAllUserNamesParam {
  final GetAllEmployeeNamesQuery request;
  SettingGetAllUserNamesParam({required this.request});
  Map<String, dynamic> toJson() {
    return {

      'request': request,
    };
  }

}
