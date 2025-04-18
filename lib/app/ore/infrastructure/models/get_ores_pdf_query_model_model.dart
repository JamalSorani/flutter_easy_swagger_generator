class GetOresPdfQueryModel {
  final List<String> ids;

  GetOresPdfQueryModel({
    required this.ids,
  });
  factory GetOresPdfQueryModel.fromJson(Map<String,dynamic>json){
  return GetOresPdfQueryModel(

      ids : json["ids"],
    );
  }

}
