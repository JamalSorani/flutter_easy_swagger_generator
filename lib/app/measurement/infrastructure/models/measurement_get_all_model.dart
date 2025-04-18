
class MeasurementGetAllModel {
  final String search;
  final int pageSize;
  final int pageIndex;
  final String sortOrder;
  final String sortColumn;
  MeasurementGetAllModel({required this.search, required this.pageSize, required this.pageIndex, required this.sortOrder, required this.sortColumn});
  factory MeasurementGetAllModel.fromJson(Map<String, dynamic> json) {
    return MeasurementGetAllModel(

      'Search': search,
      'PageSize': pageSize,
      'PageIndex': pageIndex,
      'SortOrder': sortOrder,
      'SortColumn': sortColumn,
    };
  }

}
