
import 'get_all_category_names_query_model_model.dart';
class CategoryGetAllNamesModel {
  final GetAllCategoryNamesQueryModel request;
  CategoryGetAllNamesModel({required this.request});
  factory CategoryGetAllNamesModel.fromJson(Map<String, dynamic> json) {
    return CategoryGetAllNamesModel(

      'request': request,
    };
  }

}
