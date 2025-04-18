
class ProductDeleteModel {
  final String id;
  final List<String> applicationjson;
  ProductDeleteModel({required this.id, required this.applicationjson});
  factory ProductDeleteModel.fromJson(Map<String, dynamic> json) {
    return ProductDeleteModel(

      'id': id,
      'application/json': applicationjson,
    };
  }

}
