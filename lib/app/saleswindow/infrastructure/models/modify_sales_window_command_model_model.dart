class ModifySalesWindowCommandModel {
  final String id;
  final String name;
  final String address;
  final String status;
  final List<String> employeeids;

  ModifySalesWindowCommandModel({
    required this.id,
    required this.name,
    required this.address,
    required this.status,
    required this.employeeids,
  });
  factory ModifySalesWindowCommandModel.fromJson(Map<String,dynamic>json){
  return ModifySalesWindowCommandModel(

      id : json["id"],
      name : json["name"],
      address : json["address"],
      status : json["status"],
      employeeids : json["employeeIds"],
    );
  }

}
