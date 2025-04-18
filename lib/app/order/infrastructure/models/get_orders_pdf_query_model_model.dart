class GetOrdersPdfQueryModel {
  final List<String> ids;

  GetOrdersPdfQueryModel({
    required this.ids,
  });
  factory GetOrdersPdfQueryModel.fromJson(Map<String,dynamic>json){
  return GetOrdersPdfQueryModel(

      ids : json["ids"],
    );
  }

}
