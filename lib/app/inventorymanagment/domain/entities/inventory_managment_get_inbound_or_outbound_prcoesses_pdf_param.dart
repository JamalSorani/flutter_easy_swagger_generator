
import 'get_inbound_or_outbound_processes_to_pdf_query.dart';
class InventoryManagmentGetInboundOrOutboundPrcoessesPdfParam {
  final GetInboundOrOutboundProcessesToPdfQuery getInboundOrOutboundProcessesToPdfQuery;
  InventoryManagmentGetInboundOrOutboundPrcoessesPdfParam({required this.getInboundOrOutboundProcessesToPdfQuery});
 Map<String, dynamic> toJson() {
    return
          getInboundOrOutboundProcessesToPdfQuery.toJson();
          }    
        }
          