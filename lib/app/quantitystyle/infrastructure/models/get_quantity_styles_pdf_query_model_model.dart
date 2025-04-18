class GetQuantityStylesPdfQueryModel {
  final List<String> ids;

  GetQuantityStylesPdfQueryModel({
    required this.ids,
  });
  factory GetQuantityStylesPdfQueryModel.fromJson(Map<String,dynamic>json){
  return GetQuantityStylesPdfQueryModel(

      ids : json["ids"],
    );
  }

}
