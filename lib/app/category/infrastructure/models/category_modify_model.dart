
import 'modify_category_command_model_model.dart';
class CategoryModifyModel {
  final ModifyCategoryCommandModel modifyCategoryCommandModel;
  CategoryModifyModel({required this.modifyCategoryCommandModel});
 factory CategoryModifyModel.fromJson(Map<String, dynamic> json) {
    return CategoryModifyModel(
   modifyCategoryCommandModel:       modifyCategoryCommandModel.fromJson(json),
          );
        }    
        }
          