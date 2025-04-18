class GetWarehousesPdfQueryModel {
  final List<String> ids;

  GetWarehousesPdfQueryModel({
    required this.ids,
  });
  factory GetWarehousesPdfQueryModel.fromJson(Map<String,dynamic>json){
  return GetWarehousesPdfQueryModel(

      ids : json["ids"],
    );
  }

}
