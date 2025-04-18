
import 'add_category_command_param_param.dart';
class CategoryAddParam {
  final AddCategoryCommandParam addCategoryCommandParam;
  CategoryAddParam({required this.addCategoryCommandParam});
 Map<String, dynamic> toJson() {
    return
          addCategoryCommandParam.toJson();
          }    
        }
          