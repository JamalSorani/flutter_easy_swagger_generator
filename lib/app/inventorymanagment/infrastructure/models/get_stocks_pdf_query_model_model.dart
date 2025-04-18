class GetStocksPdfQueryModel {
  final List<String> ids;

  GetStocksPdfQueryModel({
    required this.ids,
  });
  factory GetStocksPdfQueryModel.fromJson(Map<String,dynamic>json){
  return GetStocksPdfQueryModel(

      ids : json["ids"],
    );
  }

}
