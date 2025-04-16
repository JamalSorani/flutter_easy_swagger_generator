
class ProductGetByQRParam {
  final String code;
  ProductGetByQRParam({required this.code});
  Map<String, dynamic> toJson() {
    return {

      'Code': code,
    };
  }

}
