
import 'get_customers_pdf_query.dart';
class CustomerGetPdfParam {
  final GetCustomersPdfQuery getCustomersPdfQuery;
  CustomerGetPdfParam({required this.getCustomersPdfQuery});
 Map<String, dynamic> toJson() {
    return
          getCustomersPdfQuery.toJson();
          }    
        }
          