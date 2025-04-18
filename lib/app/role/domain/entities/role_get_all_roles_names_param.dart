
class RoleGetAllRolesNamesParam {
  final String search;
  RoleGetAllRolesNamesParam({required this.search});
  Map<String, dynamic> toJson() {
    return {

      'Search': search,
    };
  }

}
