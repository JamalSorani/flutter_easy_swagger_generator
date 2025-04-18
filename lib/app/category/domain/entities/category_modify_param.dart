
import 'modify_category_command_param_param.dart';
class CategoryModifyParam {
  final ModifyCategoryCommandParam modifyCategoryCommandParam;
  CategoryModifyParam({required this.modifyCategoryCommandParam});
 Map<String, dynamic> toJson() {
    return
          modifyCategoryCommandParam.toJson();
          }    
        }
          