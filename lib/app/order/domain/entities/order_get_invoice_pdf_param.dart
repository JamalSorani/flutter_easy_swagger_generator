
import 'get_invoice_pdf_query_param_param.dart';
class OrderGetInvoicePdfParam {
  final GetInvoicePdfQueryParam getInvoicePdfQueryParam;
  OrderGetInvoicePdfParam({required this.getInvoicePdfQueryParam});
 Map<String, dynamic> toJson() {
    return
          getInvoicePdfQueryParam.toJson();
          }    
        }
          