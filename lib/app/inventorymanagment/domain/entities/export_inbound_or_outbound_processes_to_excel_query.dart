class ExportInboundOrOutboundProcessesToExcelQuery {
  final dynamic ids;

  ExportInboundOrOutboundProcessesToExcelQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
