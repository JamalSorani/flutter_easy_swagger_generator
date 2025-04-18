class GetTransferProcessesPdfQuery {
  final List<String> ids;

  GetTransferProcessesPdfQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
