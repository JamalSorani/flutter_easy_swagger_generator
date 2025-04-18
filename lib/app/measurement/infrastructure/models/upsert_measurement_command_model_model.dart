class UpsertMeasurementCommandModel {
  final String id;
  final String name;
  final String description;

  UpsertMeasurementCommandModel({
    required this.id,
    required this.name,
    required this.description,
  });
  factory UpsertMeasurementCommandModel.fromJson(Map<String,dynamic>json){
  return UpsertMeasurementCommandModel(

      id : json["id"],
      name : json["name"],
      description : json["description"],
    );
  }

}
