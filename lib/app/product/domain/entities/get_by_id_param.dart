
class ProductGetByIdParam {
  final String id;
  ProductGetByIdParam({required this.id});
  Map<String, dynamic> toJson() {
    return {

      'Id': id,
    };
  }

}
