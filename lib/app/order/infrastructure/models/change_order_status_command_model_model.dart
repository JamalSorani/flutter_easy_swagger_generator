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
  Map<String, dynamic> toJson() {
    return {

      'orderId': orderid,
      'status': status,
      'employeeId': employeeid,
      'reasonForCancellation': reasonforCancellation,
    };
  }

}
