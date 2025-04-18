
import 'get_all_employee_names_query_model_model.dart';
class EmployeeGetAllNamesModel {
  final GetAllEmployeeNamesQueryModel request;
  EmployeeGetAllNamesModel({required this.request});
  factory EmployeeGetAllNamesModel.fromJson(Map<String, dynamic> json) {
    return EmployeeGetAllNamesModel(

      request: json["request"] ,
    );
  }

}
