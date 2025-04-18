
import 'get_my_profile_query_param_param.dart';
class EmployeeGetMyProfileeParam {
  final GetMyProfileQueryParam request;
  EmployeeGetMyProfileeParam({required this.request});
  Map<String, dynamic> toJson() {
    return {

      'request': request,
    };
  }

}
