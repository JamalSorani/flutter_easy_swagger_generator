
class InventoryManagmentGetInboundOrOutboundProcessByIdModel {
  final String id;
  final String search;
  InventoryManagmentGetInboundOrOutboundProcessByIdModel({required this.id, required this.search});
  factory InventoryManagmentGetInboundOrOutboundProcessByIdModel.fromJson(Map<String, dynamic> json) {
    return InventoryManagmentGetInboundOrOutboundProcessByIdModel(

      'Id': id,
      'Search': search,
    };
  }

}
