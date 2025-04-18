import 'package:either_dart/either.dart';
import '../../infrastructure/models/currency_exchange_get_model.dart';
import '../../infrastructure/models/currency_exchange_modify_model.dart';
import '../entities/currency_exchange_get_param.dart';
import '../entities/currency_exchange_modify_param.dart';

abstract class CurrencyexchangeRepository {
  Future<Either<String, CurrencyExchangeGetModel>> currencyExchangeGet({required CurrencyExchangeGetParam currencyExchangeGetParam});

  Future<Either<String, CurrencyExchangeModifyModel>> currencyExchangeModify({required CurrencyExchangeModifyParam currencyExchangeModifyParam});

}
