class UpsertRoleCommand {
  final String id;
  final String name;
  final dynamic permissions;

  UpsertRoleCommand({
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
