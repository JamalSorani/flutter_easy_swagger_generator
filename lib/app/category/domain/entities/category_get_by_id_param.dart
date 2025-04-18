
class CategoryGetByIdParam {
  final String id;
  CategoryGetByIdParam({required this.id});
  Map<String, dynamic> toJson() {
    return {

      'Id': id,
    };
  }

}
