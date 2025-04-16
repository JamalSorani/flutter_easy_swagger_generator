
class InventoryManagmentGetTransferProcessByIdParam {
  final String id;
  final String search;
  InventoryManagmentGetTransferProcessByIdParam({required this.id, required this.search});
  Map<String, dynamic> toJson() {
    return {

      'Id': id,
      'Search': search,
    };
  }

}
