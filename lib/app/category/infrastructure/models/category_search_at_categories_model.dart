
class CategorySearchAtCategoriesModel {
  final String search;
  final String status;
  CategorySearchAtCategoriesModel({required this.search, required this.status});
  factory CategorySearchAtCategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategorySearchAtCategoriesModel(

      'Search': search,
      'Status': status,
    };
  }

}
