
import 'get_all_category_names_query_param.dart';
class CategoryGetAllNamesParam {
  final GetAllCategoryNamesQuery request;
  CategoryGetAllNamesParam({required this.request});
  Map<String, dynamic> toJson() {
    return {

      'request': request,
    };
  }

}
