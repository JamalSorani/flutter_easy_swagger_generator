class ExportRolesToExcelQuery {
  final dynamic ids;

  ExportRolesToExcelQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
