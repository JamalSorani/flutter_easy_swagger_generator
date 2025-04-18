
import 'get_employees_pdf_query_param_param.dart';
class EmployeeGetPdfParam {
  final GetEmployeesPdfQueryParam getEmployeesPdfQueryParam;
  EmployeeGetPdfParam({required this.getEmployeesPdfQueryParam});
 Map<String, dynamic> toJson() {
    return
          getEmployeesPdfQueryParam.toJson();
          }    
        }
          