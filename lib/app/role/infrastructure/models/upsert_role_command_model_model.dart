class UpsertRoleCommandModel {
  final String id;
  final String name;
  final List<String> permissions;

  UpsertRoleCommandModel({
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
