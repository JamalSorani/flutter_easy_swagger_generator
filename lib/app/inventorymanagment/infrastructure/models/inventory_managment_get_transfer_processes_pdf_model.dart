
import 'get_transfer_processes_pdf_query_model_model.dart';
class InventoryManagmentGetTransferProcessesPdfModel {
  final GetTransferProcessesPdfQueryModel getTransferProcessesPdfQueryModel;
  InventoryManagmentGetTransferProcessesPdfModel({required this.getTransferProcessesPdfQueryModel});
 factory InventoryManagmentGetTransferProcessesPdfModel.fromJson(Map<String, dynamic> json) {
    return InventoryManagmentGetTransferProcessesPdfModel(
   getTransferProcessesPdfQueryModel:       GetTransferProcessesPdfQueryModel.fromJson(json),
          );
        }    
        }
          