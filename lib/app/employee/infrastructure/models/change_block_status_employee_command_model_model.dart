class ChangeBlockStatusEmployeeCommandModel {
  final String id;

  ChangeBlockStatusEmployeeCommandModel({
    required this.id,
  });
  factory ChangeBlockStatusEmployeeCommandModel.fromJson(Map<String,dynamic>json){
  return ChangeBlockStatusEmployeeCommandModel(

      id : json["id"],
    );
  }

}
