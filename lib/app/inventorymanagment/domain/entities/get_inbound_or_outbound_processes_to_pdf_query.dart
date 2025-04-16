class GetInboundOrOutboundProcessesToPdfQuery {
  final dynamic ids;

  GetInboundOrOutboundProcessesToPdfQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
