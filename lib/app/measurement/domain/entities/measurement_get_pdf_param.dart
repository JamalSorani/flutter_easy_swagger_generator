
import 'get_measurements_pdf_query_param.dart';
class MeasurementGetPdfParam {
  final GetMeasurementsPdfQuery getMeasurementsPdfQuery;
  MeasurementGetPdfParam({required this.getMeasurementsPdfQuery});
 Map<String, dynamic> toJson() {
    return
          getMeasurementsPdfQuery.toJson();
          }    
        }
          