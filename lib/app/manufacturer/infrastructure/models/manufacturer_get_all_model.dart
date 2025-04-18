
class ManufacturerGetAllModel {
  final String search;
  final int pageSize;
  final int pageIndex;
  final String sortOrder;
  final String sortColumn;
  ManufacturerGetAllModel({required this.search, required this.pageSize, required this.pageIndex, required this.sortOrder, required this.sortColumn});
  factory ManufacturerGetAllModel.fromJson(Map<String, dynamic> json) {
    return ManufacturerGetAllModel(

      'Search': search,
      'PageSize': pageSize,
      'PageIndex': pageIndex,
      'SortOrder': sortOrder,
      'SortColumn': sortColumn,
    };
  }

}
