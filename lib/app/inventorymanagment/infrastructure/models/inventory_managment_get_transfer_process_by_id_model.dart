
class InventoryManagmentGetTransferProcessByIdModel {
  final String id;
  final String search;
  InventoryManagmentGetTransferProcessByIdModel({required this.id, required this.search});
  factory InventoryManagmentGetTransferProcessByIdModel.fromJson(Map<String, dynamic> json) {
    return InventoryManagmentGetTransferProcessByIdModel(

      'Id': id,
      'Search': search,
    };
  }

}
