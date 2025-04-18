class UpsertQuantityStyleCommandModel {
  final String id;
  final String name;

  UpsertQuantityStyleCommandModel({
    required this.id,
    required this.name,
  });
  factory UpsertQuantityStyleCommandModel.fromJson(Map<String,dynamic>json){
  return UpsertQuantityStyleCommandModel(

      id : json["id"],
      name : json["name"],
    );
  }

}
