
import 'get_customers_pdf_query_param_param.dart';
class CustomerGetPdfParam {
  final GetCustomersPdfQueryParam getCustomersPdfQueryParam;
  CustomerGetPdfParam({required this.getCustomersPdfQueryParam});
 Map<String, dynamic> toJson() {
    return
          getCustomersPdfQueryParam.toJson();
          }    
        }
          