
class CategoryGetByIdModel {
  final String id;
  CategoryGetByIdModel({required this.id});
  factory CategoryGetByIdModel.fromJson(Map<String, dynamic> json) {
    return CategoryGetByIdModel(

      'Id': id,
    };
  }

}
