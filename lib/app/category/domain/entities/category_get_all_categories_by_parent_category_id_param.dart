
class CategoryGetAllCategoriesByParentCategoryIdParam {
  final String parentId;
  final String status;
  CategoryGetAllCategoriesByParentCategoryIdParam({required this.parentId, required this.status});
  Map<String, dynamic> toJson() {
    return {

      'ParentId': parentId,
      'Status': status,
    };
  }

}
