class ExportInboundOrOutboundProcessesToExcelQueryParam {
  final List<String> ids;

  ExportInboundOrOutboundProcessesToExcelQueryParam({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
