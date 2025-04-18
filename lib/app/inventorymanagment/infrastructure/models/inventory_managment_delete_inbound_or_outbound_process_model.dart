
class InventoryManagmentDeleteInboundOrOutboundProcessModel {
  final String id;
  InventoryManagmentDeleteInboundOrOutboundProcessModel({required this.id});
  factory InventoryManagmentDeleteInboundOrOutboundProcessModel.fromJson(Map<String, dynamic> json) {
    return InventoryManagmentDeleteInboundOrOutboundProcessModel(

      id: json["Id"] ,
    );
  }

}
