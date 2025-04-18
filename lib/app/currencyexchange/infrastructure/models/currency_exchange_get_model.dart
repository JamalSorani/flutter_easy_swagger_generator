
import 'get_currency_exchang_query_model_model.dart';
class CurrencyExchangeGetModel {
  final GetCurrencyExchangQueryModel request;
  CurrencyExchangeGetModel({required this.request});
  factory CurrencyExchangeGetModel.fromJson(Map<String, dynamic> json) {
    return CurrencyExchangeGetModel(

      request: json["request"] ,
    );
  }

}
