class UpsertStoreCommandModel {
  final String id;
  final String name;

  UpsertStoreCommandModel({
    required this.id,
    required this.name,
  });
  factory UpsertStoreCommandModel.fromJson(Map<String,dynamic>json){
  return UpsertStoreCommandModel(

      id : json["id"],
      name : json["name"],
    );
  }

}
