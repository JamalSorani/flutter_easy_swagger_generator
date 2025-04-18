
import 'get_currency_exchang_query_param.dart';
class CurrencyExchangeGetParam {
  final GetCurrencyExchangQuery request;
  CurrencyExchangeGetParam({required this.request});
  Map<String, dynamic> toJson() {
    return {

      'request': request,
    };
  }

}
