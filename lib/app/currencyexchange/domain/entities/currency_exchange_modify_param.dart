
import 'modify_currency_exchang_command.dart';
class CurrencyExchangeModifyParam {
  final ModifyCurrencyExchangCommand modifyCurrencyExchangCommand;
  CurrencyExchangeModifyParam({required this.modifyCurrencyExchangCommand});
 Map<String, dynamic> toJson() {
    return
          modifyCurrencyExchangCommand.toJson();
          }    
        }
          