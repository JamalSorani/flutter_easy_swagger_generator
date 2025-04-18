
import 'get_my_profile_query_model_model.dart';
class EmployeeGetMyProfileeModel {
  final GetMyProfileQueryModel request;
  EmployeeGetMyProfileeModel({required this.request});
  factory EmployeeGetMyProfileeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeGetMyProfileeModel(

      'request': request,
    };
  }

}
