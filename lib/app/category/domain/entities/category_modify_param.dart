
import 'modify_category_command.dart';
class CategoryModifyParam {
  final ModifyCategoryCommand modifyCategoryCommand;
  CategoryModifyParam({required this.modifyCategoryCommand});
 Map<String, dynamic> toJson() {
    return
          modifyCategoryCommand.toJson();
          }    
        }
          