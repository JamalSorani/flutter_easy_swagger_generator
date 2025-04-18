
import 'get_invoice_pdf_query_model_model.dart';
class OrderGetInvoicePdfModel {
  final GetInvoicePdfQueryModel getInvoicePdfQueryModel;
  OrderGetInvoicePdfModel({required this.getInvoicePdfQueryModel});
 factory OrderGetInvoicePdfModel.fromJson(Map<String, dynamic> json) {
    return OrderGetInvoicePdfModel(
   getInvoicePdfQueryModel:       getInvoicePdfQueryModel.fromJson(json),
          );
        }    
        }
          