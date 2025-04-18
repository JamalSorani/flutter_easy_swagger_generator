
import 'get_roles_pdf_query_param_param.dart';
class RoleGetPdfParam {
  final GetRolesPdfQueryParam getRolesPdfQueryParam;
  RoleGetPdfParam({required this.getRolesPdfQueryParam});
 Map<String, dynamic> toJson() {
    return
          getRolesPdfQueryParam.toJson();
          }    
        }
          