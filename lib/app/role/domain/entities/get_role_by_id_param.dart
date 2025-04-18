
class RoleGetRoleByIdParam {
  final String id;
  RoleGetRoleByIdParam({required this.id});
  Map<String, dynamic> toJson() {
    return {

      'Id': id,
    };
  }

}
