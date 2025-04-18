class UpsertRoleCommandParam {
  final String id;
  final String name;
  final List<String> permissions;

  UpsertRoleCommandParam({
    required this.id,
    required this.name,
    required this.permissions,
  });
  Map<String, dynamic> toJson() {
    return {

      'id': id,
      'name': name,
      'permissions': permissions,
    };
  }

}
