class GetRolesPdfQueryModel {
  final List<String> ids;

  GetRolesPdfQueryModel({
    required this.ids,
  });
  factory GetRolesPdfQueryModel.fromJson(Map<String,dynamic>json){
  return GetRolesPdfQueryModel(

      ids : json["ids"],
    );
  }

}
