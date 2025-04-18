class UpsertFillStyleCommandModel {
  final String id;
  final String name;

  UpsertFillStyleCommandModel({
    required this.id,
    required this.name,
  });
  factory UpsertFillStyleCommandModel.fromJson(Map<String,dynamic>json){
  return UpsertFillStyleCommandModel(

      id : json["id"],
      name : json["name"],
    );
  }

}
