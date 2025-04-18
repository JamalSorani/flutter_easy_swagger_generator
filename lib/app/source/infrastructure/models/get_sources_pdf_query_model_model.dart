class GetSourcesPdfQueryModel {
  final List<String> ids;

  GetSourcesPdfQueryModel({
    required this.ids,
  });
  factory GetSourcesPdfQueryModel.fromJson(Map<String,dynamic>json){
  return GetSourcesPdfQueryModel(

      ids : json["ids"],
    );
  }

}
