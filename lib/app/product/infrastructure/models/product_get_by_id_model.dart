
class ProductGetByIdModel {
  final String id;
  ProductGetByIdModel({required this.id});
  factory ProductGetByIdModel.fromJson(Map<String, dynamic> json) {
    return ProductGetByIdModel(

      id: json["Id"] ,
    );
  }

}
