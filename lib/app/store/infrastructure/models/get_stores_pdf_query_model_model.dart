class GetStoresPdfQueryModel {
  final List<String> ids;

  GetStoresPdfQueryModel({
    required this.ids,
  });
  factory GetStoresPdfQueryModel.fromJson(Map<String,dynamic>json){
  return GetStoresPdfQueryModel(

      ids : json["ids"],
    );
  }

}
