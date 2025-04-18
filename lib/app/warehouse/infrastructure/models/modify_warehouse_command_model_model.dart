class ModifyWarehouseCommandModel {
  final String id;
  final String name;
  final String phonenumber;
  final String address;
  final String status;
  final List<String> employeeids;

  ModifyWarehouseCommandModel({
    required this.id,
    required this.name,
    required this.phonenumber,
    required this.address,
    required this.status,
    required this.employeeids,
  });
  factory ModifyWarehouseCommandModel.fromJson(Map<String,dynamic>json){
  return ModifyWarehouseCommandModel(

      id : json["id"],
      name : json["name"],
      phonenumber : json["phoneNumber"],
      address : json["address"],
      status : json["status"],
      employeeids : json["employeeIds"],
    );
  }

}
