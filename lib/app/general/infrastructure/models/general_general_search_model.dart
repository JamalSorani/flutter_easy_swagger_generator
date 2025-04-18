
class GeneralGeneralSearchModel {
  final String search;
  final int employeePageSize;
  final int employeePageIndex;
  final int productPageSize;
  final int productPageIndex;
  final int orderPageSize;
  final int orderPageIndex;
  final int categoryPageSize;
  final int categoryPageIndex;
  GeneralGeneralSearchModel({required this.search, required this.employeePageSize, required this.employeePageIndex, required this.productPageSize, required this.productPageIndex, required this.orderPageSize, required this.orderPageIndex, required this.categoryPageSize, required this.categoryPageIndex});
  factory GeneralGeneralSearchModel.fromJson(Map<String, dynamic> json) {
    return GeneralGeneralSearchModel(

      search: json["Search"] ,
      employeePageSize: json["EmployeePageSize"] ,
      employeePageIndex: json["EmployeePageIndex"] ,
      productPageSize: json["ProductPageSize"] ,
      productPageIndex: json["ProductPageIndex"] ,
      orderPageSize: json["OrderPageSize"] ,
      orderPageIndex: json["OrderPageIndex"] ,
      categoryPageSize: json["CategoryPageSize"] ,
      categoryPageIndex: json["CategoryPageIndex"] ,
    );
  }

}
