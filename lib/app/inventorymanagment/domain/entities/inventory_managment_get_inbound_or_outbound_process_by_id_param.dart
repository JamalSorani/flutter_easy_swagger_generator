
class InventoryManagmentGetInboundOrOutboundProcessByIdParam {
  final String id;
  final String search;
  InventoryManagmentGetInboundOrOutboundProcessByIdParam({required this.id, required this.search});
  Map<String, dynamic> toJson() {
    return {

      'Id': id,
      'Search': search,
    };
  }

}
