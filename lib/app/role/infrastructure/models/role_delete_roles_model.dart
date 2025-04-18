
class RoleDeleteRolesModel {
  final String id;
  final List<String> applicationjson;
  RoleDeleteRolesModel({required this.id, required this.applicationjson});
  factory RoleDeleteRolesModel.fromJson(Map<String, dynamic> json) {
    return RoleDeleteRolesModel(

      id: json["id"] ,
      applicationjson: json["application/json"],
    );
  }

}
