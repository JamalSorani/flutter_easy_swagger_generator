class GetProductsToPdfQueryModel {
  final String saleswindowId;
  final List<String> productids;

  GetProductsToPdfQueryModel({
    required this.saleswindowId,
    required this.productids,
  });
  factory GetProductsToPdfQueryModel.fromJson(Map<String,dynamic>json){
  return GetProductsToPdfQueryModel(

      saleswindowId : json["salesWindowId"],
      productids : json["productIds"],
    );
  }

}
