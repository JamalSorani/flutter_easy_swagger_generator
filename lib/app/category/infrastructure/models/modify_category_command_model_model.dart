class ModifyCategoryCommandModel {
  final String id;
  final String name;
  final String code;
  final String description;
  final String status;

  ModifyCategoryCommandModel({
    required this.id,
    required this.name,
    required this.code,
    required this.description,
    required this.status,
  });
  factory ModifyCategoryCommandModel.fromJson(Map<String,dynamic>json){
  return ModifyCategoryCommandModel(

      id : json["id"],
      name : json["name"],
      code : json["code"],
      description : json["description"],
      status : json["status"],
    );
  }

}
