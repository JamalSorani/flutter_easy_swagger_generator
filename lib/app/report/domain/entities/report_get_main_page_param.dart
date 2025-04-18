
import 'get_main_page_query_param.dart';
class ReportGetMainPageParam {
  final GetMainPageQuery request;
  ReportGetMainPageParam({required this.request});
  Map<String, dynamic> toJson() {
    return {

      'request': request,
    };
  }

}
