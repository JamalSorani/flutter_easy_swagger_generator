import 'package:either_dart/either.dart';
import '../../infrastructure/models/inventory_managment_add_inbound_or_outbound_process_model.dart';
import '../../infrastructure/models/inventory_managment_addtransfer_process_model.dart';
import '../../infrastructure/models/inventory_managment_get_all_stocks_model.dart';
import '../../infrastructure/models/inventory_managment_get_all_inbound_and_outbound_processes_model.dart';
import '../../infrastructure/models/inventory_managment_get_all_transfer_processes_model.dart';
import '../../infrastructure/models/inventory_managment_modify_inbound_or_outbound_process_model.dart';
import '../../infrastructure/models/inventory_managment_modify_transfer_process_model.dart';
import '../../infrastructure/models/inventory_managment_delete_transfer_process_model.dart';
import '../../infrastructure/models/inventory_managment_delete_inbound_or_outbound_process_model.dart';
import '../../infrastructure/models/inventory_managment_get_product_by_id_model.dart';
import '../../infrastructure/models/inventory_managment_get_inbound_or_outbound_process_by_id_model.dart';
import '../../infrastructure/models/inventory_managment_get_transfer_process_by_id_model.dart';
import '../../infrastructure/models/inventory_managment_export_stocks_to_excel_model.dart';
import '../../infrastructure/models/inventory_managment_export_inbound_or_outbound_processes_to_excel_model.dart';
import '../../infrastructure/models/inventory_managment_export_transfer_processes_to_excel_model.dart';
import '../../infrastructure/models/inventory_managment_get_transfer_processes_pdf_model.dart';
import '../../infrastructure/models/inventory_managment_get_inbound_or_outbound_prcoesses_pdf_model.dart';
import '../../infrastructure/models/inventory_managment_get_stocks_pdf_model.dart';
import '../entities/inventory_managment_add_inbound_or_outbound_process_param.dart';
import '../entities/inventory_managment_addtransfer_process_param.dart';
import '../entities/inventory_managment_get_all_stocks_param.dart';
import '../entities/inventory_managment_get_all_inbound_and_outbound_processes_param.dart';
import '../entities/inventory_managment_get_all_transfer_processes_param.dart';
import '../entities/inventory_managment_modify_inbound_or_outbound_process_param.dart';
import '../entities/inventory_managment_modify_transfer_process_param.dart';
import '../entities/inventory_managment_delete_transfer_process_param.dart';
import '../entities/inventory_managment_delete_inbound_or_outbound_process_param.dart';
import '../entities/inventory_managment_get_product_by_id_param.dart';
import '../entities/inventory_managment_get_inbound_or_outbound_process_by_id_param.dart';
import '../entities/inventory_managment_get_transfer_process_by_id_param.dart';
import '../entities/inventory_managment_export_stocks_to_excel_param.dart';
import '../entities/inventory_managment_export_inbound_or_outbound_processes_to_excel_param.dart';
import '../entities/inventory_managment_export_transfer_processes_to_excel_param.dart';
import '../entities/inventory_managment_get_transfer_processes_pdf_param.dart';
import '../entities/inventory_managment_get_inbound_or_outbound_prcoesses_pdf_param.dart';
import '../entities/inventory_managment_get_stocks_pdf_param.dart';

abstract class InventorymanagmentRepository {
  Future<Either<String, InventoryManagmentAddInboundOrOutboundProcessModel>> inventoryManagmentAddInboundOrOutboundProcess({required InventoryManagmentAddInboundOrOutboundProcessParam inventoryManagmentAddInboundOrOutboundProcessParam});

  Future<Either<String, InventoryManagmentAddtransferProcessModel>> inventoryManagmentAddtransferProcess({required InventoryManagmentAddtransferProcessParam inventoryManagmentAddtransferProcessParam});

  Future<Either<String, InventoryManagmentGetAllStocksModel>> inventoryManagmentGetAllStocks({required InventoryManagmentGetAllStocksParam inventoryManagmentGetAllStocksParam});

  Future<Either<String, InventoryManagmentGetAllInboundAndOutboundProcessesModel>> inventoryManagmentGetAllInboundAndOutboundProcesses({required InventoryManagmentGetAllInboundAndOutboundProcessesParam inventoryManagmentGetAllInboundAndOutboundProcessesParam});

  Future<Either<String, InventoryManagmentGetAllTransferProcessesModel>> inventoryManagmentGetAllTransferProcesses({required InventoryManagmentGetAllTransferProcessesParam inventoryManagmentGetAllTransferProcessesParam});

  Future<Either<String, InventoryManagmentModifyInboundOrOutboundProcessModel>> inventoryManagmentModifyInboundOrOutboundProcess({required InventoryManagmentModifyInboundOrOutboundProcessParam inventoryManagmentModifyInboundOrOutboundProcessParam});

  Future<Either<String, InventoryManagmentModifyTransferProcessModel>> inventoryManagmentModifyTransferProcess({required InventoryManagmentModifyTransferProcessParam inventoryManagmentModifyTransferProcessParam});

  Future<Either<String, InventoryManagmentDeleteTransferProcessModel>> inventoryManagmentDeleteTransferProcess({required InventoryManagmentDeleteTransferProcessParam inventoryManagmentDeleteTransferProcessParam});

  Future<Either<String, InventoryManagmentDeleteInboundOrOutboundProcessModel>> inventoryManagmentDeleteInboundOrOutboundProcess({required InventoryManagmentDeleteInboundOrOutboundProcessParam inventoryManagmentDeleteInboundOrOutboundProcessParam});

  Future<Either<String, InventoryManagmentGetProductByIdModel>> inventoryManagmentGetProductById({required InventoryManagmentGetProductByIdParam inventoryManagmentGetProductByIdParam});

  Future<Either<String, InventoryManagmentGetInboundOrOutboundProcessByIdModel>> inventoryManagmentGetInboundOrOutboundProcessById({required InventoryManagmentGetInboundOrOutboundProcessByIdParam inventoryManagmentGetInboundOrOutboundProcessByIdParam});

  Future<Either<String, InventoryManagmentGetTransferProcessByIdModel>> inventoryManagmentGetTransferProcessById({required InventoryManagmentGetTransferProcessByIdParam inventoryManagmentGetTransferProcessByIdParam});

  Future<Either<String, InventoryManagmentExportStocksToExcelModel>> inventoryManagmentExportStocksToExcel({required InventoryManagmentExportStocksToExcelParam inventoryManagmentExportStocksToExcelParam});

  Future<Either<String, InventoryManagmentExportInboundOrOutboundProcessesToExcelModel>> inventoryManagmentExportInboundOrOutboundProcessesToExcel({required InventoryManagmentExportInboundOrOutboundProcessesToExcelParam inventoryManagmentExportInboundOrOutboundProcessesToExcelParam});

  Future<Either<String, InventoryManagmentExportTransferProcessesToExcelModel>> inventoryManagmentExportTransferProcessesToExcel({required InventoryManagmentExportTransferProcessesToExcelParam inventoryManagmentExportTransferProcessesToExcelParam});

  Future<Either<String, InventoryManagmentGetTransferProcessesPdfModel>> inventoryManagmentGetTransferProcessesPdf({required InventoryManagmentGetTransferProcessesPdfParam inventoryManagmentGetTransferProcessesPdfParam});

  Future<Either<String, InventoryManagmentGetInboundOrOutboundPrcoessesPdfModel>> inventoryManagmentGetInboundOrOutboundPrcoessesPdf({required InventoryManagmentGetInboundOrOutboundPrcoessesPdfParam inventoryManagmentGetInboundOrOutboundPrcoessesPdfParam});

  Future<Either<String, InventoryManagmentGetStocksPdfModel>> inventoryManagmentGetStocksPdf({required InventoryManagmentGetStocksPdfParam inventoryManagmentGetStocksPdfParam});

}
