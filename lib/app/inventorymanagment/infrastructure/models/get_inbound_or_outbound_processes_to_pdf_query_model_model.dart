class GetInboundOrOutboundProcessesToPdfQueryModel {
  final List<String> ids;

  GetInboundOrOutboundProcessesToPdfQueryModel({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
