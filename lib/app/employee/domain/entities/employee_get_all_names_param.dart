
import 'get_all_employee_names_query_param.dart';
class EmployeeGetAllNamesParam {
  final GetAllEmployeeNamesQuery request;
  EmployeeGetAllNamesParam({required this.request});
  Map<String, dynamic> toJson() {
    return {

      'request': request,
    };
  }

}
