
import 'get_employees_pdf_query.dart';
class EmployeeGetPdfParam {
  final GetEmployeesPdfQuery getEmployeesPdfQuery;
  EmployeeGetPdfParam({required this.getEmployeesPdfQuery});
 Map<String, dynamic> toJson() {
    return
          getEmployeesPdfQuery.toJson();
          }    
        }
          