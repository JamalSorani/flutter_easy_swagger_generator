class GetTransferProcessesPdfQueryModel {
  final List<String> ids;

  GetTransferProcessesPdfQueryModel({
    required this.ids,
  });
  factory GetTransferProcessesPdfQueryModel.fromJson(Map<String,dynamic>json){
  return GetTransferProcessesPdfQueryModel(

      ids : json["ids"],
    );
  }

}
