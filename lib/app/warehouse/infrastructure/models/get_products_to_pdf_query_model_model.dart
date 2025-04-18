class GetProductsToPdfQueryModel {
  final String warehouseid;
  final List<String> productids;

  GetProductsToPdfQueryModel({
    required this.warehouseid,
    required this.productids,
  });
  factory GetProductsToPdfQueryModel.fromJson(Map<String,dynamic>json){
  return GetProductsToPdfQueryModel(

      warehouseid : json["warehouseId"],
      productids : json["productIds"],
    );
  }

}
