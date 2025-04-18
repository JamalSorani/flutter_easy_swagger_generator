class GetCustomersPdfQueryModel {
  final List<String> ids;

  GetCustomersPdfQueryModel({
    required this.ids,
  });
  factory GetCustomersPdfQueryModel.fromJson(Map<String,dynamic>json){
  return GetCustomersPdfQueryModel(

      ids : json["ids"],
    );
  }

}
