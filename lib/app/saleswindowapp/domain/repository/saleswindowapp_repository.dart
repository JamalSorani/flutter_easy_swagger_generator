import 'package:either_dart/either.dart';
import '../../infrastructure/models/sales_window_app_order_add_from_cart_model.dart';
import '../../infrastructure/models/sales_window_app_order_modify_model.dart';
import '../../infrastructure/models/sales_window_app_order_add_model.dart';
import '../../infrastructure/models/sales_window_app_product_get_similar_model.dart';
import '../../infrastructure/models/sales_window_app_report_get_main_page_model.dart';
import '../../infrastructure/models/sales_window_app_report_get_most_requested_products_model.dart';
import '../../infrastructure/models/sales_window_app_report_get_most_requested_packages_model.dart';
import '../../infrastructure/models/sales_window_app_report_get_product_reports_model.dart';
import '../../infrastructure/models/sales_window_app_shopping_cart_get_by_id_model.dart';
import '../../infrastructure/models/sales_window_app_shopping_cart_get_all_model.dart';
import '../../infrastructure/models/sales_window_app_shopping_cart_add_model.dart';
import '../../infrastructure/models/sales_window_app_shopping_cart_delete_model.dart';
import '../../infrastructure/models/sales_window_app_shopping_cart_get_all_names_model.dart';
import '../../infrastructure/models/sales_window_app_shopping_cart_modify_model.dart';
import '../../infrastructure/models/sales_window_app_shopping_cart_delete_from_shopping_cart_model.dart';
import '../entities/sales_window_app_order_add_from_cart_param.dart';
import '../entities/sales_window_app_order_modify_param.dart';
import '../entities/sales_window_app_order_add_param.dart';
import '../entities/sales_window_app_product_get_similar_param.dart';
import '../entities/sales_window_app_report_get_main_page_param.dart';
import '../entities/sales_window_app_report_get_most_requested_products_param.dart';
import '../entities/sales_window_app_report_get_most_requested_packages_param.dart';
import '../entities/sales_window_app_report_get_product_reports_param.dart';
import '../entities/sales_window_app_shopping_cart_get_by_id_param.dart';
import '../entities/sales_window_app_shopping_cart_get_all_param.dart';
import '../entities/sales_window_app_shopping_cart_add_param.dart';
import '../entities/sales_window_app_shopping_cart_delete_param.dart';
import '../entities/sales_window_app_shopping_cart_get_all_names_param.dart';
import '../entities/sales_window_app_shopping_cart_modify_param.dart';
import '../entities/sales_window_app_shopping_cart_delete_from_shopping_cart_param.dart';

abstract class SaleswindowappRepository {
  Future<Either<String, SalesWindowAppOrderAddFromCartModel>> salesWindowAppOrderAddFromCart({required SalesWindowAppOrderAddFromCartParam salesWindowAppOrderAddFromCartParam});

  Future<Either<String, SalesWindowAppOrderModifyModel>> salesWindowAppOrderModify({required SalesWindowAppOrderModifyParam salesWindowAppOrderModifyParam});

  Future<Either<String, SalesWindowAppOrderAddModel>> salesWindowAppOrderAdd({required SalesWindowAppOrderAddParam salesWindowAppOrderAddParam});

  Future<Either<String, SalesWindowAppProductGetSimilarModel>> salesWindowAppProductGetSimilar({required SalesWindowAppProductGetSimilarParam salesWindowAppProductGetSimilarParam});

  Future<Either<String, SalesWindowAppReportGetMainPageModel>> salesWindowAppReportGetMainPage({required SalesWindowAppReportGetMainPageParam salesWindowAppReportGetMainPageParam});

  Future<Either<String, SalesWindowAppReportGetMostRequestedProductsModel>> salesWindowAppReportGetMostRequestedProducts({required SalesWindowAppReportGetMostRequestedProductsParam salesWindowAppReportGetMostRequestedProductsParam});

  Future<Either<String, SalesWindowAppReportGetMostRequestedPackagesModel>> salesWindowAppReportGetMostRequestedPackages({required SalesWindowAppReportGetMostRequestedPackagesParam salesWindowAppReportGetMostRequestedPackagesParam});

  Future<Either<String, SalesWindowAppReportGetProductReportsModel>> salesWindowAppReportGetProductReports({required SalesWindowAppReportGetProductReportsParam salesWindowAppReportGetProductReportsParam});

  Future<Either<String, SalesWindowAppShoppingCartGetByIdModel>> salesWindowAppShoppingCartGetById({required SalesWindowAppShoppingCartGetByIdParam salesWindowAppShoppingCartGetByIdParam});

  Future<Either<String, SalesWindowAppShoppingCartGetAllModel>> salesWindowAppShoppingCartGetAll({required SalesWindowAppShoppingCartGetAllParam salesWindowAppShoppingCartGetAllParam});

  Future<Either<String, SalesWindowAppShoppingCartAddModel>> salesWindowAppShoppingCartAdd({required SalesWindowAppShoppingCartAddParam salesWindowAppShoppingCartAddParam});

  Future<Either<String, SalesWindowAppShoppingCartDeleteModel>> salesWindowAppShoppingCartDelete({required SalesWindowAppShoppingCartDeleteParam salesWindowAppShoppingCartDeleteParam});

  Future<Either<String, SalesWindowAppShoppingCartGetAllNamesModel>> salesWindowAppShoppingCartGetAllNames({required SalesWindowAppShoppingCartGetAllNamesParam salesWindowAppShoppingCartGetAllNamesParam});

  Future<Either<String, SalesWindowAppShoppingCartModifyModel>> salesWindowAppShoppingCartModify({required SalesWindowAppShoppingCartModifyParam salesWindowAppShoppingCartModifyParam});

  Future<Either<String, SalesWindowAppShoppingCartDeleteFromShoppingCartModel>> salesWindowAppShoppingCartDeleteFromShoppingCart({required SalesWindowAppShoppingCartDeleteFromShoppingCartParam salesWindowAppShoppingCartDeleteFromShoppingCartParam});

}
