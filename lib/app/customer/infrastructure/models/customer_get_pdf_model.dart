
import 'get_customers_pdf_query_model_model.dart';
class CustomerGetPdfModel {
  final GetCustomersPdfQueryModel getCustomersPdfQueryModel;
  CustomerGetPdfModel({required this.getCustomersPdfQueryModel});
 factory CustomerGetPdfModel.fromJson(Map<String, dynamic> json) {
    return CustomerGetPdfModel(
   getCustomersPdfQueryModel:       getCustomersPdfQueryModel.fromJson(json),
          );
        }    
        }
          