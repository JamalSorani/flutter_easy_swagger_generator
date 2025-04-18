
import 'add_category_command_model_model.dart';
class CategoryAddModel {
  final AddCategoryCommandModel addCategoryCommandModel;
  CategoryAddModel({required this.addCategoryCommandModel});
 factory CategoryAddModel.fromJson(Map<String, dynamic> json) {
    return CategoryAddModel(
   addCategoryCommandModel:       AddCategoryCommandModel.fromJson(json),
          );
        }    
        }
          