
import 'get_employees_pdf_query_model_model.dart';
class EmployeeGetPdfModel {
  final GetEmployeesPdfQueryModel getEmployeesPdfQueryModel;
  EmployeeGetPdfModel({required this.getEmployeesPdfQueryModel});
 factory EmployeeGetPdfModel.fromJson(Map<String, dynamic> json) {
    return EmployeeGetPdfModel(
   getEmployeesPdfQueryModel:       getEmployeesPdfQueryModel.fromJson(json),
          );
        }    
        }
          