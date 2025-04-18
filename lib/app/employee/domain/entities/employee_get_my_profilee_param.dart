
import 'get_my_profile_query_param.dart';
class EmployeeGetMyProfileeParam {
  final GetMyProfileQuery request;
  EmployeeGetMyProfileeParam({required this.request});
  Map<String, dynamic> toJson() {
    return {

      'request': request,
    };
  }

}
