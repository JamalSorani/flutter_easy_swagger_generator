class GetInboundOrOutboundProcessesToPdfQueryModel {
  final List<String> ids;

  GetInboundOrOutboundProcessesToPdfQueryModel({
    required this.ids,
  });
  factory GetInboundOrOutboundProcessesToPdfQueryModel.fromJson(Map<String,dynamic>json){
  return GetInboundOrOutboundProcessesToPdfQueryModel(

      ids : json["ids"],
    );
  }

}
