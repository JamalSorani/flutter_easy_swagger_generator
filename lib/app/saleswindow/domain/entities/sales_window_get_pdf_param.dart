
import 'get_sales_windows_pdf_query.dart';
class SalesWindowGetPdfParam {
  final GetSalesWindowsPdfQuery getSalesWindowsPdfQuery;
  SalesWindowGetPdfParam({required this.getSalesWindowsPdfQuery});
 Map<String, dynamic> toJson() {
    return
          getSalesWindowsPdfQuery.toJson();
          }    
        }
          