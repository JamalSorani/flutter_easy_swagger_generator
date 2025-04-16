class GetTransferProcessesPdfQuery {
  final dynamic ids;

  GetTransferProcessesPdfQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
