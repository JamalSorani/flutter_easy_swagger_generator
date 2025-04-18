
import 'get_all_customer_names_query_param_param.dart';
class CustomerGetNamesParam {
  final GetAllCustomerNamesQueryParam request;
  CustomerGetNamesParam({required this.request});
  Map<String, dynamic> toJson() {
    return {

      'request': request,
    };
  }

}
