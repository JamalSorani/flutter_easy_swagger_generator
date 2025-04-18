
import 'get_all_category_names_query_param_param.dart';
class CategoryGetAllNamesParam {
  final GetAllCategoryNamesQueryParam request;
  CategoryGetAllNamesParam({required this.request});
  Map<String, dynamic> toJson() {
    return {

      'request': request,
    };
  }

}
