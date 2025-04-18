
class SalesWindowAppShoppingCartGetAllModel {
  final int pageSize;
  final int pageIndex;
  final String sortOrder;
  final String sortColumn;
  SalesWindowAppShoppingCartGetAllModel({required this.pageSize, required this.pageIndex, required this.sortOrder, required this.sortColumn});
  factory SalesWindowAppShoppingCartGetAllModel.fromJson(Map<String, dynamic> json) {
    return SalesWindowAppShoppingCartGetAllModel(

      'PageSize': pageSize,
      'PageIndex': pageIndex,
      'SortOrder': sortOrder,
      'SortColumn': sortColumn,
    };
  }

}
