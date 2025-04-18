class GetEmployeesPdfQueryModel {
  final List<String> ids;

  GetEmployeesPdfQueryModel({
    required this.ids,
  });
  factory GetEmployeesPdfQueryModel.fromJson(Map<String,dynamic>json){
  return GetEmployeesPdfQueryModel(

      ids : json["ids"],
    );
  }

}
