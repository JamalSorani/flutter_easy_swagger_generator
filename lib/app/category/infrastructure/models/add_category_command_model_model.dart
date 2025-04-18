class AddCategoryCommandModel {
  final String name;
  final String parentcategoryId;
  final String code;
  final String description;

  AddCategoryCommandModel({
    required this.name,
    required this.parentcategoryId,
    required this.code,
    required this.description,
  });
  Map<String, dynamic> toJson() {
    return {

      'name': name,
      'parentCategoryId': parentcategoryId,
      'code': code,
      'description': description,
    };
  }

}
