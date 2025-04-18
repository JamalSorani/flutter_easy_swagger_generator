
class StoreGetAllModel {
  final String search;
  final int pageSize;
  final int pageIndex;
  final String sortOrder;
  final String sortColumn;
  StoreGetAllModel({required this.search, required this.pageSize, required this.pageIndex, required this.sortOrder, required this.sortColumn});
  factory StoreGetAllModel.fromJson(Map<String, dynamic> json) {
    return StoreGetAllModel(

      'Search': search,
      'PageSize': pageSize,
      'PageIndex': pageIndex,
      'SortOrder': sortOrder,
      'SortColumn': sortColumn,
    };
  }

}
