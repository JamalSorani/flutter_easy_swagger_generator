class UpsertManufacturerCommandModel {
  final String id;
  final String name;
  final String description;

  UpsertManufacturerCommandModel({
    required this.id,
    required this.name,
    required this.description,
  });
  factory UpsertManufacturerCommandModel.fromJson(Map<String,dynamic>json){
  return UpsertManufacturerCommandModel(

      id : json["id"],
      name : json["name"],
      description : json["description"],
    );
  }

}
