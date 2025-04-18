
class CategoryGetCategoriesBySearchModel {
  final String id;
  final String status;
  CategoryGetCategoriesBySearchModel({required this.id, required this.status});
  factory CategoryGetCategoriesBySearchModel.fromJson(Map<String, dynamic> json) {
    return CategoryGetCategoriesBySearchModel(

      'Id': id,
      'Status': status,
    };
  }

}
