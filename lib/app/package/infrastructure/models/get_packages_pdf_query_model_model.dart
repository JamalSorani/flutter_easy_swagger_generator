class GetPackagesPdfQueryModel {
  final List<String> ids;

  GetPackagesPdfQueryModel({
    required this.ids,
  });
  factory GetPackagesPdfQueryModel.fromJson(Map<String,dynamic>json){
  return GetPackagesPdfQueryModel(

      ids : json["ids"],
    );
  }

}
