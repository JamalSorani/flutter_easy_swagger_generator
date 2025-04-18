class GetTransferProcessesPdfQueryModel {
  final List<String> ids;

  GetTransferProcessesPdfQueryModel({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
