
import 'get_roles_pdf_query_model_model.dart';
class RoleGetPdfModel {
  final GetRolesPdfQueryModel getRolesPdfQueryModel;
  RoleGetPdfModel({required this.getRolesPdfQueryModel});
 factory RoleGetPdfModel.fromJson(Map<String, dynamic> json) {
    return RoleGetPdfModel(
   getRolesPdfQueryModel:       GetRolesPdfQueryModel.fromJson(json),
          );
        }    
        }
          