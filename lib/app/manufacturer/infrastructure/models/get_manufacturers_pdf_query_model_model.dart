class GetManufacturersPdfQueryModel {
  final List<String> ids;

  GetManufacturersPdfQueryModel({
    required this.ids,
  });
  factory GetManufacturersPdfQueryModel.fromJson(Map<String,dynamic>json){
  return GetManufacturersPdfQueryModel(

      ids : json["ids"],
    );
  }

}
