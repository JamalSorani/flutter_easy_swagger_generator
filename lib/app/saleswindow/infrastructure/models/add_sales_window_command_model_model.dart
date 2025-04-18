class AddSalesWindowCommandModel {
  final String name;
  final String address;
  final List<String> employeeids;

  AddSalesWindowCommandModel({
    required this.name,
    required this.address,
    required this.employeeids,
  });
  factory AddSalesWindowCommandModel.fromJson(Map<String,dynamic>json){
  return AddSalesWindowCommandModel(

      name : json["name"],
      address : json["address"],
      employeeids : json["employeeIds"],
    );
  }

}
