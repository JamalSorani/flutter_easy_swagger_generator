class ChangeOrderStatusCommandModel {
  final String orderid;
  final String status;
  final String employeeid;
  final String reasonforCancellation;

  ChangeOrderStatusCommandModel({
    required this.orderid,
    required this.status,
    required this.employeeid,
    required this.reasonforCancellation,
  });
  factory ChangeOrderStatusCommandModel.fromJson(Map<String,dynamic>json){
  return ChangeOrderStatusCommandModel(

      orderid : json["orderId"],
      status : json["status"],
      employeeid : json["employeeId"],
      reasonforCancellation : json["reasonForCancellation"],
    );
  }

}
