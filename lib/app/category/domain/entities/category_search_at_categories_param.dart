
class CategorySearchAtCategoriesParam {
  final String search;
  final String status;
  CategorySearchAtCategoriesParam({required this.search, required this.status});
  Map<String, dynamic> toJson() {
    return {

      'Search': search,
      'Status': status,
    };
  }

}
