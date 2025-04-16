
import 'get_roles_pdf_query.dart';
class RoleGetPdfParam {
  final GetRolesPdfQuery getRolesPdfQuery;
  RoleGetPdfParam({required this.getRolesPdfQuery});
 Map<String, dynamic> toJson() {
    return
          getRolesPdfQuery.toJson();
          }    
        }
          