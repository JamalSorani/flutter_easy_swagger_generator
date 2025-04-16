
import 'add_category_command.dart';
class CategoryAddParam {
  final AddCategoryCommand addCategoryCommand;
  CategoryAddParam({required this.addCategoryCommand});
 Map<String, dynamic> toJson() {
    return
          addCategoryCommand.toJson();
          }    
        }
          