class GetInboundOrOutboundProcessesToPdfQuery {
  final List<String> ids;

  GetInboundOrOutboundProcessesToPdfQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
