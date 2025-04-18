
import 'get_main_page_query_param_param.dart';
class ReportGetMainPageParam {
  final GetMainPageQueryParam request;
  ReportGetMainPageParam({required this.request});
  Map<String, dynamic> toJson() {
    return {

      'request': request,
    };
  }

}
