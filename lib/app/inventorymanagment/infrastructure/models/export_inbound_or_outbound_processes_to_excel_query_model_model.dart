class ExportInboundOrOutboundProcessesToExcelQueryModel {
  final List<String> ids;

  ExportInboundOrOutboundProcessesToExcelQueryModel({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
