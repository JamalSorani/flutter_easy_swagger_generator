
import 'get_all_customer_names_query_model_model.dart';
class CustomerGetNamesModel {
  final GetAllCustomerNamesQueryModel request;
  CustomerGetNamesModel({required this.request});
  factory CustomerGetNamesModel.fromJson(Map<String, dynamic> json) {
    return CustomerGetNamesModel(

      'request': request,
    };
  }

}
