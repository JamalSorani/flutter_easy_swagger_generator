
class CategoryGetCategoriesBySearchParam {
  final String id;
  final String status;
  CategoryGetCategoriesBySearchParam({required this.id, required this.status});
  Map<String, dynamic> toJson() {
    return {

      'Id': id,
      'Status': status,
    };
  }

}
