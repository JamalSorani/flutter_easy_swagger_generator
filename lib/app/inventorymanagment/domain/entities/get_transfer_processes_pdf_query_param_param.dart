class GetTransferProcessesPdfQueryParam {
  final List<String> ids;

  GetTransferProcessesPdfQueryParam({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
