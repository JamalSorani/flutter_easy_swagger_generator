
import 'get_invoice_pdf_query_param.dart';
class OrderGetInvoicePdfParam {
  final GetInvoicePdfQuery getInvoicePdfQuery;
  OrderGetInvoicePdfParam({required this.getInvoicePdfQuery});
 Map<String, dynamic> toJson() {
    return
          getInvoicePdfQuery.toJson();
          }    
        }
          