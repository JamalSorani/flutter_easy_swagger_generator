
import 'get_currency_exchang_query_param_param.dart';
class CurrencyExchangeGetParam {
  final GetCurrencyExchangQueryParam request;
  CurrencyExchangeGetParam({required this.request});
  Map<String, dynamic> toJson() {
    return {

      'request': request,
    };
  }

}
