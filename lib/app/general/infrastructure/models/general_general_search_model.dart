
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

      'Search': search,
      'EmployeePageSize': employeePageSize,
      'EmployeePageIndex': employeePageIndex,
      'ProductPageSize': productPageSize,
      'ProductPageIndex': productPageIndex,
      'OrderPageSize': orderPageSize,
      'OrderPageIndex': orderPageIndex,
      'CategoryPageSize': categoryPageSize,
      'CategoryPageIndex': categoryPageIndex,
    };
  }

}
