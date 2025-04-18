class UpsertOreCommandModel {
  final String id;
  final String name;

  UpsertOreCommandModel({
    required this.id,
    required this.name,
  });
  factory UpsertOreCommandModel.fromJson(Map<String,dynamic>json){
  return UpsertOreCommandModel(

      id : json["id"],
      name : json["name"],
    );
  }

}
