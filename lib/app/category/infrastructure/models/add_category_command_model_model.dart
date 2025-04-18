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
  factory AddCategoryCommandModel.fromJson(Map<String,dynamic>json){
  return AddCategoryCommandModel(

      name : json["name"],
      parentcategoryId : json["parentCategoryId"],
      code : json["code"],
      description : json["description"],
    );
  }

}
