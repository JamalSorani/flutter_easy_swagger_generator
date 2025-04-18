import 'package:either_dart/either.dart';
import '../../infrastructure/models/report_get_main_page_model.dart';
import '../../infrastructure/models/report_get_all_low_stocks_model.dart';
import '../entities/report_get_main_page_param.dart';
import '../entities/report_get_all_low_stocks_param.dart';

abstract class ReportRepository {
  Future<Either<String, ReportGetMainPageModel>> reportGetMainPage({required ReportGetMainPageParam reportGetMainPageParam});

  Future<Either<String, ReportGetAllLowStocksModel>> reportGetAllLowStocks({required ReportGetAllLowStocksParam reportGetAllLowStocksParam});

}
