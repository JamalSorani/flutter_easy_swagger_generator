class ExportInboundOrOutboundProcessesToExcelQuery {
  final List<String> ids;

  ExportInboundOrOutboundProcessesToExcelQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
