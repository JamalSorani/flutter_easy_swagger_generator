
import 'modify_currency_exchang_command_param_param.dart';
class CurrencyExchangeModifyParam {
  final ModifyCurrencyExchangCommandParam modifyCurrencyExchangCommandParam;
  CurrencyExchangeModifyParam({required this.modifyCurrencyExchangCommandParam});
 Map<String, dynamic> toJson() {
    return
          modifyCurrencyExchangCommandParam.toJson();
          }    
        }
          