
class ProductGetByQRModel {
  final String code;
  ProductGetByQRModel({required this.code});
  factory ProductGetByQRModel.fromJson(Map<String, dynamic> json) {
    return ProductGetByQRModel(

      'Code': code,
    };
  }

}
