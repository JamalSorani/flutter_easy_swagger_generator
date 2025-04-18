
class EmployeeGetByIdModel {
  final String id;
  EmployeeGetByIdModel({required this.id});
  factory EmployeeGetByIdModel.fromJson(Map<String, dynamic> json) {
    return EmployeeGetByIdModel(

      'Id': id,
    };
  }

}
