
class CategoryDeleteModel {
  final String id;
  CategoryDeleteModel({required this.id});
  factory CategoryDeleteModel.fromJson(Map<String, dynamic> json) {
    return CategoryDeleteModel(

      'Id': id,
    };
  }

}
