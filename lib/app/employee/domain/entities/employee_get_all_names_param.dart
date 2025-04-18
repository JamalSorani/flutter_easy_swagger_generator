
import 'get_all_employee_names_query_param_param.dart';
class EmployeeGetAllNamesParam {
  final GetAllEmployeeNamesQueryParam request;
  EmployeeGetAllNamesParam({required this.request});
  Map<String, dynamic> toJson() {
    return {

      'request': request,
    };
  }

}
