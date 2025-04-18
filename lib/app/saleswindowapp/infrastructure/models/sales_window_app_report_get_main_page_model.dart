
import 'get_main_page_query_model_model.dart';
class SalesWindowAppReportGetMainPageModel {
  final GetMainPageQueryModel request;
  SalesWindowAppReportGetMainPageModel({required this.request});
  factory SalesWindowAppReportGetMainPageModel.fromJson(Map<String, dynamic> json) {
    return SalesWindowAppReportGetMainPageModel(

      'request': request,
    };
  }

}
