class ExportOresToExcelQuery {
  final dynamic ids;

  ExportOresToExcelQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
