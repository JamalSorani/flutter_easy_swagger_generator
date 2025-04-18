
import 'modify_currency_exchang_command_model_model.dart';
class CurrencyExchangeModifyModel {
  final ModifyCurrencyExchangCommandModel modifyCurrencyExchangCommandModel;
  CurrencyExchangeModifyModel({required this.modifyCurrencyExchangCommandModel});
 factory CurrencyExchangeModifyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyExchangeModifyModel(
   modifyCurrencyExchangCommandModel:       ModifyCurrencyExchangCommandModel.fromJson(json),
          );
        }    
        }
          