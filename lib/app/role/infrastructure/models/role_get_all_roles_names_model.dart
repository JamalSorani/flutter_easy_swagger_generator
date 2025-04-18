
class RoleGetAllRolesNamesModel {
  final String search;
  RoleGetAllRolesNamesModel({required this.search});
  factory RoleGetAllRolesNamesModel.fromJson(Map<String, dynamic> json) {
    return RoleGetAllRolesNamesModel(

      search: json["Search"] ,
    );
  }

}
