
class CategoryGetAllCategoriesByParentCategoryIdModel {
  final String parentId;
  final String status;
  CategoryGetAllCategoriesByParentCategoryIdModel({required this.parentId, required this.status});
  factory CategoryGetAllCategoriesByParentCategoryIdModel.fromJson(Map<String, dynamic> json) {
    return CategoryGetAllCategoriesByParentCategoryIdModel(

      parentId: json["ParentId"] ,
      status: json["Status"] ,
    );
  }

}
