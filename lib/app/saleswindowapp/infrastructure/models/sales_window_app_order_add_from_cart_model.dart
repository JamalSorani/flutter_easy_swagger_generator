
class SalesWindowAppOrderAddFromCartModel {
  final String shoppingCartId;
  final String customerId;
  final String phoneNumber;
  final String note;
  final List<String> files;
  SalesWindowAppOrderAddFromCartModel({required this.shoppingCartId, required this.customerId, required this.phoneNumber, required this.note, required this.files});
  factory SalesWindowAppOrderAddFromCartModel.fromJson(Map<String, dynamic> json) {
    return SalesWindowAppOrderAddFromCartModel(

      shoppingCartId: json["ShoppingCartId"] ,
      customerId: json["CustomerId"] ,
      phoneNumber: json["PhoneNumber"] ,
      note: json["Note"] ,
      files: json["Files"] ,
    );
  }

}
