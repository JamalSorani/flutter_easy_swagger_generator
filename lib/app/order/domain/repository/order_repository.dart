import 'package:either_dart/either.dart';
import '../../infrastructure/models/order_get_all_model.dart';
import '../../infrastructure/models/order_get_by_id_model.dart';
import '../../infrastructure/models/order_add_model.dart';
import '../../infrastructure/models/order_modify_model.dart';
import '../../infrastructure/models/order_get_invoice_by_order_id_model.dart';
import '../../infrastructure/models/order_delete_model.dart';
import '../../infrastructure/models/order_change_status_model.dart';
import '../../infrastructure/models/order_export_to_excel_model.dart';
import '../../infrastructure/models/order_get_orders_pdf_model.dart';
import '../../infrastructure/models/order_get_invoice_pdf_model.dart';
import '../entities/order_get_all_param.dart';
import '../entities/order_get_by_id_param.dart';
import '../entities/order_add_param.dart';
import '../entities/order_modify_param.dart';
import '../entities/order_get_invoice_by_order_id_param.dart';
import '../entities/order_delete_param.dart';
import '../entities/order_change_status_param.dart';
import '../entities/order_export_to_excel_param.dart';
import '../entities/order_get_orders_pdf_param.dart';
import '../entities/order_get_invoice_pdf_param.dart';

abstract class OrderRepository {
  Future<Either<String, OrderGetAllModel>> orderGetAll({required OrderGetAllParam orderGetAllParam});

  Future<Either<String, OrderGetByIdModel>> orderGetById({required OrderGetByIdParam orderGetByIdParam});

  Future<Either<String, OrderAddModel>> orderAdd({required OrderAddParam orderAddParam});

  Future<Either<String, OrderModifyModel>> orderModify({required OrderModifyParam orderModifyParam});

  Future<Either<String, OrderGetInvoiceByOrderIdModel>> orderGetInvoiceByOrderId({required OrderGetInvoiceByOrderIdParam orderGetInvoiceByOrderIdParam});

  Future<Either<String, OrderDeleteModel>> orderDelete({required OrderDeleteParam orderDeleteParam});

  Future<Either<String, OrderChangeStatusModel>> orderChangeStatus({required OrderChangeStatusParam orderChangeStatusParam});

  Future<Either<String, OrderExportToExcelModel>> orderExportToExcel({required OrderExportToExcelParam orderExportToExcelParam});

  Future<Either<String, OrderGetOrdersPdfModel>> orderGetOrdersPdf({required OrderGetOrdersPdfParam orderGetOrdersPdfParam});

  Future<Either<String, OrderGetInvoicePdfModel>> orderGetInvoicePdf({required OrderGetInvoicePdfParam orderGetInvoicePdfParam});

}
