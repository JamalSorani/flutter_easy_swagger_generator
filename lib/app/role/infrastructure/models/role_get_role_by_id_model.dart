
class RoleGetRoleByIdModel {
  final String id;
  RoleGetRoleByIdModel({required this.id});
  factory RoleGetRoleByIdModel.fromJson(Map<String, dynamic> json) {
    return RoleGetRoleByIdModel(

      id: json["Id"] ,
    );
  }

}
