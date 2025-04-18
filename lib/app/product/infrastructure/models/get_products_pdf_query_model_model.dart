class GetProductsPdfQueryModel {
  final List<String> ids;

  GetProductsPdfQueryModel({
    required this.ids,
  });
  factory GetProductsPdfQueryModel.fromJson(Map<String,dynamic>json){
  return GetProductsPdfQueryModel(

      ids : json["ids"],
    );
  }

}
