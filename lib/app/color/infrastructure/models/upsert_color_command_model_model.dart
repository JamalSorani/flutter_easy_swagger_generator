class UpsertColorCommandModel {
  final String id;
  final String name;
  final String tonality;

  UpsertColorCommandModel({
    required this.id,
    required this.name,
    required this.tonality,
  });
  factory UpsertColorCommandModel.fromJson(Map<String,dynamic>json){
  return UpsertColorCommandModel(

      id : json["id"],
      name : json["name"],
      tonality : json["tonality"],
    );
  }

}
