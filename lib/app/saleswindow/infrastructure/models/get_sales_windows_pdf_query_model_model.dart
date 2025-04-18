class GetSalesWindowsPdfQueryModel {
  final List<String> ids;

  GetSalesWindowsPdfQueryModel({
    required this.ids,
  });
  factory GetSalesWindowsPdfQueryModel.fromJson(Map<String,dynamic>json){
  return GetSalesWindowsPdfQueryModel(

      ids : json["ids"],
    );
  }

}
