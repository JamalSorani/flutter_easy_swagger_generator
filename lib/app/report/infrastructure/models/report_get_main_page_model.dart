
import 'get_main_page_query_model_model.dart';
class ReportGetMainPageModel {
  final GetMainPageQueryModel request;
  ReportGetMainPageModel({required this.request});
  factory ReportGetMainPageModel.fromJson(Map<String, dynamic> json) {
    return ReportGetMainPageModel(

      'request': request,
    };
  }

}
