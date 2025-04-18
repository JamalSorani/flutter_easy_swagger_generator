
import 'get_sales_windows_pdf_query_model_model.dart';
class SalesWindowGetPdfModel {
  final GetSalesWindowsPdfQueryModel getSalesWindowsPdfQueryModel;
  SalesWindowGetPdfModel({required this.getSalesWindowsPdfQueryModel});
 factory SalesWindowGetPdfModel.fromJson(Map<String, dynamic> json) {
    return SalesWindowGetPdfModel(
   getSalesWindowsPdfQueryModel:       GetSalesWindowsPdfQueryModel.fromJson(json),
          );
        }    
        }
          