class ExportInboundOrOutboundProcessesToExcelQueryModel {
  final List<String> ids;

  ExportInboundOrOutboundProcessesToExcelQueryModel({
    required this.ids,
  });
  factory ExportInboundOrOutboundProcessesToExcelQueryModel.fromJson(Map<String,dynamic>json){
  return ExportInboundOrOutboundProcessesToExcelQueryModel(

      ids : json["ids"],
    );
  }

}
