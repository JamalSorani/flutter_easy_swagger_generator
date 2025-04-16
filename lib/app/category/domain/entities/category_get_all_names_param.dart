
import 'get_all_category_names_query.dart';
class CategoryGetAllNamesParam {
  final GetAllCategoryNamesQuery request;
  CategoryGetAllNamesParam({required this.request});
  Map<String, dynamic> toJson() {
    return {

      'request': request,
    };
  }

}
