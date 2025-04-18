class UpsertRoleCommandModel {
  final String id;
  final String name;
  final List<String> permissions;

  UpsertRoleCommandModel({
    required this.id,
    required this.name,
    required this.permissions,
  });
  factory UpsertRoleCommandModel.fromJson(Map<String,dynamic>json){
  return UpsertRoleCommandModel(

      id : json["id"],
      name : json["name"],
      permissions : json["permissions"],
    );
  }

}
