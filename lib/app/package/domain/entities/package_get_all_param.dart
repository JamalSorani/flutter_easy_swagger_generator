import 'sort_type_param_param.dart';
class PackageGetAllParam {
  final String searchTerm;
  final String classId;
  final String similarTo;
  final String studyStageId;
  final String dateFrom;
  final String dateTo;
  final int pageSize;
  final int pageIndex;
  final SortTypeParam sortOrder;
  final String sortColumn;
  PackageGetAllParam({required this.searchTerm, required this.classId, required this.similarTo, required this.studyStageId, required this.dateFrom, required this.dateTo, required this.pageSize, required this.pageIndex, required this.sortOrder, required this.sortColumn});
  Map<String, dynamic> toJson() {
    return {
      'SearchTerm': searchTerm,
      'ClassId': classId,
      'SimilarTo': similarTo,
      'StudyStageId': studyStageId,
      'DateFrom': dateFrom,
      'DateTo': dateTo,
      'PageSize': pageSize,
      'PageIndex': pageIndex,
      'SortOrder': sortOrder,
      'SortColumn': sortColumn,
    };
  }
}
