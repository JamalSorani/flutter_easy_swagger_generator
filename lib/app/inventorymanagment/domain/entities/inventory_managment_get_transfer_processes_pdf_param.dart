
import 'get_transfer_processes_pdf_query.dart';
class InventoryManagmentGetTransferProcessesPdfParam {
  final GetTransferProcessesPdfQuery getTransferProcessesPdfQuery;
  InventoryManagmentGetTransferProcessesPdfParam({required this.getTransferProcessesPdfQuery});
 Map<String, dynamic> toJson() {
    return
          getTransferProcessesPdfQuery.toJson();
          }    
        }
          