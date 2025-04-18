
class EmployeeDeleteModel {
  final String id;
  final List<String> applicationjson;
  EmployeeDeleteModel({required this.id, required this.applicationjson});
  factory EmployeeDeleteModel.fromJson(Map<String, dynamic> json) {
    return EmployeeDeleteModel(

      id: json["id"] ,
      applicationjson: json["application/json"],
    );
  }

}
