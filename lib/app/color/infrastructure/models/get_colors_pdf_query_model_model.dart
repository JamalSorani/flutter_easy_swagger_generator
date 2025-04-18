class GetColorsPdfQueryModel {
  final List<String> ids;

  GetColorsPdfQueryModel({
    required this.ids,
  });
  factory GetColorsPdfQueryModel.fromJson(Map<String,dynamic>json){
  return GetColorsPdfQueryModel(

      ids : json["ids"],
    );
  }

}
