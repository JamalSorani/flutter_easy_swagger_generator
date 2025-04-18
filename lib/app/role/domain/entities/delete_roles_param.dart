
class RoleDeleteRolesParam {
  final String id;
  final List<String> applicationjson;
  RoleDeleteRolesParam({required this.id, required this.applicationjson});
  Map<String, dynamic> toJson() {
    return {

      'id': id,
    };
  }

}
