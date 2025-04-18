class AddWarehouseCommandModel {
  final String name;
  final List<String> employeeids;
  final String phonenumber;
  final String address;

  AddWarehouseCommandModel({
    required this.name,
    required this.employeeids,
    required this.phonenumber,
    required this.address,
  });
  factory AddWarehouseCommandModel.fromJson(Map<String,dynamic>json){
  return AddWarehouseCommandModel(

      name : json["name"],
      employeeids : json["employeeIds"],
      phonenumber : json["phoneNumber"],
      address : json["address"],
    );
  }

}
