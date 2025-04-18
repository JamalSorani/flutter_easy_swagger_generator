import 'package:either_dart/either.dart';
import '../../infrastructure/models/warehouse_get_all_model.dart';
import '../../infrastructure/models/warehouse_get_by_id_model.dart';
import '../../infrastructure/models/warehouse_add_model.dart';
import '../../infrastructure/models/warehouse_modify_model.dart';
import '../../infrastructure/models/warehouse_delete_model.dart';
import '../../infrastructure/models/warehouse_get_all_products_by_warehouse_id_model.dart';
import '../../infrastructure/models/warehouse_export_to_excel_model.dart';
import '../../infrastructure/models/warehouse_get_pdf_model.dart';
import '../../infrastructure/models/warehouse_get_products_pdf_model.dart';
import '../../infrastructure/models/warehouse_export_prodduct_to_excel_model.dart';
import '../entities/warehouse_get_all_param.dart';
import '../entities/warehouse_get_by_id_param.dart';
import '../entities/warehouse_add_param.dart';
import '../entities/warehouse_modify_param.dart';
import '../entities/warehouse_delete_param.dart';
import '../entities/warehouse_get_all_products_by_warehouse_id_param.dart';
import '../entities/warehouse_export_to_excel_param.dart';
import '../entities/warehouse_get_pdf_param.dart';
import '../entities/warehouse_get_products_pdf_param.dart';
import '../entities/warehouse_export_prodduct_to_excel_param.dart';

abstract class WarehouseRepository {
  Future<Either<String, WarehouseGetAllModel>> warehouseGetAll({required WarehouseGetAllParam warehouseGetAllParam});

  Future<Either<String, WarehouseGetByIdModel>> warehouseGetById({required WarehouseGetByIdParam warehouseGetByIdParam});

  Future<Either<String, WarehouseAddModel>> warehouseAdd({required WarehouseAddParam warehouseAddParam});

  Future<Either<String, WarehouseModifyModel>> warehouseModify({required WarehouseModifyParam warehouseModifyParam});

  Future<Either<String, WarehouseDeleteModel>> warehouseDelete({required WarehouseDeleteParam warehouseDeleteParam});

  Future<Either<String, WarehouseGetAllProductsByWarehouseIdModel>> warehouseGetAllProductsByWarehouseId({required WarehouseGetAllProductsByWarehouseIdParam warehouseGetAllProductsByWarehouseIdParam});

  Future<Either<String, WarehouseExportToExcelModel>> warehouseExportToExcel({required WarehouseExportToExcelParam warehouseExportToExcelParam});

  Future<Either<String, WarehouseGetPdfModel>> warehouseGetPdf({required WarehouseGetPdfParam warehouseGetPdfParam});

  Future<Either<String, WarehouseGetProductsPdfModel>> warehouseGetProductsPdf({required WarehouseGetProductsPdfParam warehouseGetProductsPdfParam});

  Future<Either<String, WarehouseExportProdductToExcelModel>> warehouseExportProdductToExcel({required WarehouseExportProdductToExcelParam warehouseExportProdductToExcelParam});

}
