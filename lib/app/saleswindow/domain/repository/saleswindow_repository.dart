import 'package:either_dart/either.dart';
import '../../infrastructure/models/sales_window_get_all_model.dart';
import '../../infrastructure/models/sales_window_get_by_id_model.dart';
import '../../infrastructure/models/sales_window_add_model.dart';
import '../../infrastructure/models/sales_window_modify_model.dart';
import '../../infrastructure/models/sales_window_delete_model.dart';
import '../../infrastructure/models/sales_window_get_all_products_by_sales_window_id_model.dart';
import '../../infrastructure/models/sales_window_export_to_excel_model.dart';
import '../../infrastructure/models/sales_window_get_pdf_model.dart';
import '../../infrastructure/models/sales_window_get_products_pdf_model.dart';
import '../../infrastructure/models/sales_window_export_prodduct_to_excel_model.dart';
import '../entities/sales_window_get_all_param.dart';
import '../entities/sales_window_get_by_id_param.dart';
import '../entities/sales_window_add_param.dart';
import '../entities/sales_window_modify_param.dart';
import '../entities/sales_window_delete_param.dart';
import '../entities/sales_window_get_all_products_by_sales_window_id_param.dart';
import '../entities/sales_window_export_to_excel_param.dart';
import '../entities/sales_window_get_pdf_param.dart';
import '../entities/sales_window_get_products_pdf_param.dart';
import '../entities/sales_window_export_prodduct_to_excel_param.dart';

abstract class SaleswindowRepository {
  Future<Either<String, SalesWindowGetAllModel>> salesWindowGetAll({required SalesWindowGetAllParam salesWindowGetAllParam});

  Future<Either<String, SalesWindowGetByIdModel>> salesWindowGetById({required SalesWindowGetByIdParam salesWindowGetByIdParam});

  Future<Either<String, SalesWindowAddModel>> salesWindowAdd({required SalesWindowAddParam salesWindowAddParam});

  Future<Either<String, SalesWindowModifyModel>> salesWindowModify({required SalesWindowModifyParam salesWindowModifyParam});

  Future<Either<String, SalesWindowDeleteModel>> salesWindowDelete({required SalesWindowDeleteParam salesWindowDeleteParam});

  Future<Either<String, SalesWindowGetAllProductsBySalesWindowIdModel>> salesWindowGetAllProductsBySalesWindowId({required SalesWindowGetAllProductsBySalesWindowIdParam salesWindowGetAllProductsBySalesWindowIdParam});

  Future<Either<String, SalesWindowExportToExcelModel>> salesWindowExportToExcel({required SalesWindowExportToExcelParam salesWindowExportToExcelParam});

  Future<Either<String, SalesWindowGetPdfModel>> salesWindowGetPdf({required SalesWindowGetPdfParam salesWindowGetPdfParam});

  Future<Either<String, SalesWindowGetProductsPdfModel>> salesWindowGetProductsPdf({required SalesWindowGetProductsPdfParam salesWindowGetProductsPdfParam});

  Future<Either<String, SalesWindowExportProdductToExcelModel>> salesWindowExportProdductToExcel({required SalesWindowExportProdductToExcelParam salesWindowExportProdductToExcelParam});

}
