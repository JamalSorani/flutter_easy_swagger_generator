
class PackageGetAllProductsModel {
  final String search;
  final int pageSize;
  final int pageIndex;
  final String sortOrder;
  final String sortColumn;
  PackageGetAllProductsModel({required this.search, required this.pageSize, required this.pageIndex, required this.sortOrder, required this.sortColumn});
  factory PackageGetAllProductsModel.fromJson(Map<String, dynamic> json) {
    return PackageGetAllProductsModel(

      'Search': search,
      'PageSize': pageSize,
      'PageIndex': pageIndex,
      'SortOrder': sortOrder,
      'SortColumn': sortColumn,
    };
  }

}
