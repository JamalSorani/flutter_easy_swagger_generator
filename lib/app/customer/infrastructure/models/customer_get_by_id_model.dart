
class CustomerGetByIdModel {
  final String id;
  CustomerGetByIdModel({required this.id});
  factory CustomerGetByIdModel.fromJson(Map<String, dynamic> json) {
    return CustomerGetByIdModel(

      'Id': id,
    };
  }

}
