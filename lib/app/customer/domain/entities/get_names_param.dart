
import 'get_all_customer_names_query_param.dart';
class CustomerGetNamesParam {
  final GetAllCustomerNamesQuery request;
  CustomerGetNamesParam({required this.request});
  Map<String, dynamic> toJson() {
    return {

      'request': request,
    };
  }

}
