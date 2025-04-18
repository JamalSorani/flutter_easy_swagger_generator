
import 'get_measurements_pdf_query_param_param.dart';
class MeasurementGetPdfParam {
  final GetMeasurementsPdfQueryParam getMeasurementsPdfQueryParam;
  MeasurementGetPdfParam({required this.getMeasurementsPdfQueryParam});
 Map<String, dynamic> toJson() {
    return
          getMeasurementsPdfQueryParam.toJson();
          }    
        }
          