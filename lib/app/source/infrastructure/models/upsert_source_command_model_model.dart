class UpsertSourceCommandModel {
  final String id;
  final String name;
  final String description;

  UpsertSourceCommandModel({
    required this.id,
    required this.name,
    required this.description,
  });
  factory UpsertSourceCommandModel.fromJson(Map<String,dynamic>json){
  return UpsertSourceCommandModel(

      id : json["id"],
      name : json["name"],
      description : json["description"],
    );
  }

}
