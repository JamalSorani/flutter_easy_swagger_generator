class GetInboundOrOutboundProcessesToPdfQueryParam {
  final List<String> ids;

  GetInboundOrOutboundProcessesToPdfQueryParam({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
